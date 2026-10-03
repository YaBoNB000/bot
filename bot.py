#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Luraph 解混淆 Discord 机器人
============================

用法（在频道里）：

    .deobf  + 上传被保护的脚本   -> 自动识别 Luraph 版本，解混淆并把结果发回来
    .help                        -> 指令列表
    斜杠命令：/deobf、/help、/stats

结果文件顶部会自动带上水印：deobf by https://discord.gg/ck3k7nAVS
（解混淆器自带的 Discord 署名会被去掉，见 deobf_runner.apply_watermark）

底层调用的是 KryptIT/luraph-v15-v14.x-deobfuscator（见 deobf_runner.py）：
v14.7/14.8/14.9 走 cli.py，v15 走 deob.py --obfuscator luraph_v15。

启动：
    python bot.py            # 读 config.json / 环境变量
    python bot.py --check    # 只做环境自检，不连 Discord
"""
from __future__ import annotations

import argparse
import asyncio
import io
import json
import logging
import os
import random
import re
import shutil
import sys
import time
import zipfile
from dataclasses import dataclass, field
from datetime import datetime, timezone
from logging.handlers import RotatingFileHandler
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

#: 双击运行 / pythonw 时的兜底：修好控制台、编码，出错时不让窗口闪掉。
#: 单独一个 winpause.py，缺了也能跑（下面有降级实现）。
try:
    from winpause import (ensure_console, fix_output_encoding,
                          launched_by_double_click, pause, run_cli)
except ImportError:  # pragma: no cover
    def ensure_console() -> None: ...
    def fix_output_encoding() -> None: ...
    def launched_by_double_click(argv=None) -> bool: return False
    def pause(code=None, reason="") -> None: ...
    def run_cli(main, argv=None) -> int:
        return int(main() if argv is None else main(argv))

ensure_console()
fix_output_encoding()

#: 依赖缺失是新手最常见的一步，这里给一条能照着做的提示，而不是一堆 traceback。
_MISSING_HINT = (
    "缺少依赖 discord.py。\n"
    "  在 PowerShell 里执行：  py -m pip install -r requirements.txt\n"
    "  （或者直接双击 setup.bat，它会自动装好）"
)
try:
    import discord
    from discord import app_commands
except ImportError:  # pragma: no cover
    print("[x] " + _MISSING_HINT, file=sys.stderr)
    if launched_by_double_click():        # 双击时别让窗口闪掉
        pause(code=1, reason=_MISSING_HINT)
    raise SystemExit(1)
except Exception as exc:                  # 装了但导入出错（版本太低等）
    print(f"[x] 导入 discord.py 失败：{exc}\n    试试升级：py -m pip install -U -r requirements.txt",
          file=sys.stderr)
    raise SystemExit(1)
from deobf_runner import (  # noqa: E402
    DeobfNotFound, Options, Result, check_environment, find_deobf_dir,
    prepare_input, run_job,
)

HERE = Path(__file__).resolve().parent
log = logging.getLogger("deobf-bot")

#: 用户指令上的反应：进行中 -> 完成 / 失败
LOADING_EMOJI = "⏳"
DONE_EMOJI = "✅"
FAIL_EMOJI = "❌"

# --------------------------------------------------------------------------
# 配置
# --------------------------------------------------------------------------

DEFAULTS: dict = {
    "token": "",                    # 也可以放在环境变量 DISCORD_TOKEN
    "deobf_dir": "",                # 留空自动探测；DEOBF_DIR 环境变量优先
    "python": "",                   # 留空用当前解释器
    "prefixes": [".", "!"],
    "commands": ["deobf", "deob", "help"],
    "ephemeral_results": False,     # 斜杠命令的结果是否只有自己可见
    "allow_dm": True,
    "allowed_guild_ids": [],        # 空 = 所有服务器
    "allowed_user_ids": [],         # 空 = 所有人
    "max_concurrent_jobs": 1,       # 同时跑几个解混淆（吃 CPU，建议 1~2）
    "queue_size": 20,
    "user_cooldown_seconds": 60,
    "max_input_mb": 25,
    "max_upload_mb": 8,             # Discord 附件上限，超了就打包 zip
    "harness_timeout": 150,         # 传给解混淆器的单次运行超时（秒）
    "time_budget": 30,              # 被追踪脚本的时间预算（秒）
    "devirt_rounds": 200,
    "max_runs": 12,
    "job_timeout_seconds": 900,     # 机器人侧硬超时，到点强杀
    "progress_interval_seconds": 8,
    "keep_work": True,              # 保留 work/<job>/ 里的输入、日志、结果
    "sync_guild_id": 0,             # 填服务器 ID 可让斜杠命令立刻生效（0 = 全局）
}


def read_text_smart(path: Path) -> tuple[str, str]:
    """读文本：先按 utf-8（含 BOM），不行就按系统 ANSI（记事本存成 ANSI 的常见情况）。

    返回 (文本, 实际用的编码)。
    """
    raw = path.read_bytes()
    if raw[:2] in (b"\xff\xfe", b"\xfe\xff"):
        # 记事本"另存为 → Unicode"就是 UTF-16（带 BOM），让 codec 自己看 BOM 判断大小端
        try:
            return raw.decode("utf-16"), "utf-16"
        except UnicodeDecodeError:
            pass
    elif len(raw) >= 2 and raw[0:1] == b"\x00" and raw[1:2] != b"\x00":
        return raw.decode("utf-16-be", errors="replace"), "utf-16-be"     # 无 BOM 的 UTF-16 BE
    elif len(raw) >= 2 and raw[1:2] == b"\x00" and raw[0:1] != b"\x00":
        return raw.decode("utf-16-le", errors="replace"), "utf-16-le"     # 无 BOM 的 UTF-16 LE
    for enc in ("utf-8-sig",):
        try:
            return raw.decode(enc), enc
        except UnicodeDecodeError:
            pass
    ansi = "mbcs" if os.name == "nt" else "gbk"              # Windows 上就是系统代码页
    for enc in (ansi, "latin-1"):
        try:
            return raw.decode(enc), enc
        except (UnicodeDecodeError, LookupError):
            continue
    return raw.decode("utf-8", errors="replace"), "utf-8"


def load_config(path: Path) -> dict:
    cfg = dict(DEFAULTS)
    if path.is_file():
        text, enc = read_text_smart(path)
        if enc != "utf-8-sig":
            # 记事本存成 ANSI/GBK 或 UTF-16：这次先读出来，顺手改回 UTF-8，下次就正常了
            print(f"[!] {path.name} 不是 UTF-8 编码（按 {enc} 读的），已自动转回 UTF-8。")
            try:
                path.write_text(text, encoding="utf-8")
            except OSError:
                pass
        try:
            data = json.loads(text)
        except json.JSONDecodeError as exc:
            raise SystemExit(
                f"[x] {path.name} 不是合法的 JSON（第 {exc.lineno} 行第 {exc.colno} 列：{exc.msg}）。\n"
                f"    常见原因：少了逗号、多了逗号、中文引号、或者把整段删掉了。\n"
                f"    最省事的做法：删掉 config.json，再双击一次 setup.bat 重新生成。"
            ) from exc
        if isinstance(data, dict):
            cfg.update({k: v for k, v in data.items() if not k.startswith("_")})
            # 顺手把整文件里不该有的东西去掉（每一条都是真实踩过的坑）
            token = str(cfg.get("token") or "").strip().strip('"').strip("'").strip()
            cfg["token"] = token
    if os.environ.get("DISCORD_TOKEN"):
        cfg["token"] = os.environ["DISCORD_TOKEN"].strip().strip('"').strip("'")
    if os.environ.get("DEOBF_DIR"):
        cfg["deobf_dir"] = os.environ["DEOBF_DIR"]
    return cfg


#: Bot Token 大致长这样：三段用点分开（xxx.yyy.zzz）。只用来提醒，不做硬性拒绝。
TOKEN_SHAPE = re.compile(r"^[A-Za-z0-9_\-]{20,}\.[A-Za-z0-9_\-]{5,}\.[A-Za-z0-9_\-]{20,}$")


def setup_logging(logs_dir: Path, level: int = logging.INFO) -> None:
    fmt = logging.Formatter("%(asctime)s %(levelname)-7s %(name)s: %(message)s",
                            "%Y-%m-%d %H:%M:%S")
    root = logging.getLogger()
    root.setLevel(level)
    root.handlers.clear()

    stream = sys.stdout or sys.stderr          # pythonw 下两个都可能是 None
    if stream is not None:
        sh = logging.StreamHandler(stream)
        sh.setFormatter(fmt)
        root.addHandler(sh)

    try:                                        # 目录只读 / 被占用也不该让程序起不来
        logs_dir.mkdir(parents=True, exist_ok=True)
        fh = RotatingFileHandler(logs_dir / "bot.log", maxBytes=4 << 20,
                                 backupCount=5, encoding="utf-8")
        fh.setFormatter(fmt)
        root.addHandler(fh)
    except OSError as exc:
        if stream is not None:
            print(f"[!] 写不了日志文件（{logs_dir}：{exc}），这次只在屏幕上显示日志。",
                  file=stream)

    logging.getLogger("discord").setLevel(logging.WARNING)
    logging.getLogger("discord.http").setLevel(logging.WARNING)


# --------------------------------------------------------------------------
# 指令解析
# --------------------------------------------------------------------------

CMD_RE = re.compile(
    r"^(?P<prefix>[^\w\s])(?P<name>[A-Za-z]+)(?:/(?P<ver>[0-9A-Za-z._]*))?(?P<rest>.*)$"
)

#: 已经移除的参数：老用法给一句明确提示，而不是含糊的"看不懂"
REMOVED_FLAGS = (
    "trace", "traceonly", "no-devirt", "nodevirt", "行为追踪",
    "strings", "str", "string", "debug", "keep", "中间文件",
)

NUM_FLAGS = {
    "timeout": ("harness_timeout", 10, 1800),
    "t": ("harness_timeout", 10, 1800),
    "budget": ("budget", 1, 600),
    "b": ("budget", 1, 600),
    "rounds": ("rounds", 1, 5000),
    "r": ("rounds", 1, 5000),
    "runs": ("max_runs", 1, 100),
}

#: 指令表：.help 由它渲染，改指令只改这张表
COMMAND_TABLE = (
    (".deobf", "+ 文件", "自动识别 Luraph 版本并解混淆"),
    (".help", "", "显示本帮助"),
    ("/deobf", "", "同 .deobf（斜杠命令）"),
    ("/stats", "", "查看队列与运行状态"),
)


def render_help() -> str:
    """极简帮助：只有"命令 —— 作用"。"""
    lines = ["**指令**"]
    for name, extra, desc in COMMAND_TABLE:
        cmd = f"{name} {extra}".strip()
        lines.append(f"`{cmd}` — {desc}")
    return "\n".join(lines)


HELP_TEXT = render_help()


@dataclass
class ParseResult:
    opt: Options | None = None
    want_help: bool = False
    error: str = ""


def parse_command(content: str, cfg: dict) -> ParseResult | None:
    """把 `.deobf`（可带附件）解析成 Options；`.help` 直接给帮助。不是本机器人的指令则返回 None。"""
    if not content:
        return None
    content = content.lstrip()        # 手滑在开头多打空格也认
    prefixes = tuple(cfg["prefixes"])
    names = tuple(n.lower() for n in cfg["commands"])
    if not content.startswith(prefixes):
        return None

    m = CMD_RE.match(content.strip())
    if not m or m.group("name").lower() not in names:
        return None

    out = ParseResult()
    rest = (m.group("rest") or "").replace(",", " ").split()
    if m.group("name").lower() == "help" \
            or any(t.lower() in ("help", "?", "-h", "帮助") for t in rest):
        out.want_help = True
        return out

    opt = Options(
        version="auto",                    # 版本一律自动识别，命令只有 .deobf 一个
        harness_timeout=int(cfg["harness_timeout"]),
        budget=int(cfg["time_budget"]),
        rounds=int(cfg["devirt_rounds"]),
        max_runs=int(cfg["max_runs"]),
    )
    for tok in rest:
        low = tok.lower()
        if re.fullmatch(r"v?\d+(?:\.\d+)?", low):
            # 老写法 .deobf/14.7 / .deobf 14.7：版本现在自动识别，这里直接忽略
            continue
        if low in REMOVED_FLAGS:
            out.error = f"`{low}` 已经移除了，直接 `.deobf` + 文件即可（用 `.help` 看用法）"
            return out
        if "=" in tok:
            key, _, val = tok.partition("=")
            key, val = key.strip().lower(), val.strip()
            if key in NUM_FLAGS:
                field_name, lo, hi = NUM_FLAGS[key]
                try:
                    num = int(float(val))
                except ValueError:
                    out.error = f"`{key}` 需要一个数字，收到 `{val}`"
                    return out
                setattr(opt, field_name, max(lo, min(hi, num)))
                continue
        out.error = f"看不懂的参数 `{tok}`（用 `.help` 看用法）"
        return out

    out.opt = opt
    return out


# --------------------------------------------------------------------------
# 任务与队列
# --------------------------------------------------------------------------

@dataclass
class Job:
    id: str                                  # 任务编号，XXXX-XXX
    user_id: int
    user_name: str
    guild_id: int | None
    channel: discord.abc.Messageable
    source_name: str
    opt: Options
    workdir: Path
    src_path: Path
    msg: discord.Message | None = None      # 用户发指令的那条消息（上面挂反应）
    created: float = field(default_factory=time.time)
    # 运行时状态
    status_msg: discord.Message | None = None
    cancel_event: asyncio.Event = field(default_factory=asyncio.Event)
    started: float | None = None
    stage: str = "排队中"
    detail: str = ""
    round_no: int = 0
    result: Result | None = None
    _last_error: str = ""

    @property
    def elapsed(self) -> float:
        return (time.time() - self.started) if self.started else 0.0

    # --- 实时解析解混淆器输出的日志行，转成给用户看的阶段说明 ---
    def consume_line(self, line: str) -> None:
        s = line.strip()
        low = s.lower()
        try:
            if "tracing" in low and "run" in low:
                m = re.search(r"run\s+(\d+)", low)
                self.stage = "🔍 在模拟环境里追踪脚本运行"
                self.detail = f"第 {m.group(1)} 次运行" if m else ""
            elif "devirt round" in low or "devirtualizing" in low:
                m = re.search(r"round\s+(\d+)", low)
                if m:
                    self.round_no = int(m.group(1))
                self.stage = "🧠 反虚拟化（把 VM 字节码还原成 Luau）"
                self.detail = f"第 {self.round_no} 轮"
            elif "constants decoded" in low:
                m = re.search(r"decoded=(\d+)", low)
                self.stage = "🧩 回收运行时常量"
                self.detail = f"已解出 {m.group(1)} 个" if m else ""
            elif s.startswith("[+] wrote") or "result:" in low:
                self.stage = "📦 正在写出结果"
                self.detail = ""
            elif "run status" in low:
                self.stage = "🏁 收尾"
                self.detail = s.split(":", 1)[1].strip() if ":" in s else ""
            elif s.startswith("[!]"):
                self._last_error = s[3:].strip()[:160]
        except Exception:  # 解析失败绝不能影响任务
            pass


class JobQueue:
    """固定数量 worker + 有界队列。解混淆吃 CPU，默认只开 1 个 worker。"""

    def __init__(self, bot: "DeobfBot") -> None:
        self.bot = bot
        self.queue: asyncio.Queue[Job | None] = asyncio.Queue(maxsize=bot.cfg["queue_size"])
        self.workers: list[asyncio.Task] = []
        self.running: dict[str, Job] = {}
        self.done_count = 0
        self.failed_count = 0
        self._used_ids: set[str] = set()
        self._lock = asyncio.Lock()

    async def start(self) -> None:
        for i in range(max(1, int(self.bot.cfg["max_concurrent_jobs"]))):
            self.workers.append(asyncio.create_task(self._worker(i), name=f"deobf-worker-{i}"))

    async def stop(self) -> None:
        for job in list(self.running.values()):
            job.cancel_event.set()
        for w in self.workers:
            w.cancel()
        await asyncio.gather(*self.workers, return_exceptions=True)

    def new_id(self) -> str:
        """任务编号：XXXX-XXX（4 位 + 3 位数字），同一个进程内不重复。"""
        for _ in range(1000):
            jid = "%04d-%03d" % (random.randrange(10000), random.randrange(1000))
            if jid not in self._used_ids:
                self._used_ids.add(jid)
                return jid
        # 极端情况下（编号池几乎用尽）退化成顺序编号，保证一定能发出任务
        jid = "%04d-%03d" % (len(self._used_ids) % 10000, len(self._used_ids) % 1000)
        self._used_ids.add(jid)
        return jid

    @property
    def depth(self) -> int:
        return self.queue.qsize() + len(self.running)

    async def _worker(self, idx: int) -> None:
        log.info("worker-%d 就绪", idx)
        while True:
            job = await self.queue.get()
            if job is None:
                self.queue.task_done()
                return
            self.running[job.id] = job
            try:
                await self._run_job(job)
            except asyncio.CancelledError:
                job.cancel_event.set()
                raise
            except Exception:
                log.exception("任务 %s 异常", job.id)
            finally:
                self.running.pop(job.id, None)
                self.queue.task_done()

    async def _run_job(self, job: Job) -> None:
        # 排队期间就被取消 -> 直接给结果，不启动进程
        if job.cancel_event.is_set():
            res = Result(ok=False, cancelled=True, note="任务在排队时被取消。")
            job.result = res
            self.failed_count += 1
            await self.bot.deliver(job, res)
            return

        job.started = time.time()
        job.stage = "🚀 正在启动解混淆器"
        await self._render(job)

        pump = asyncio.create_task(self._progress_pump(job))
        try:
            res = await run_job(
                deobf_dir=self.bot.deobf_dir,
                src=job.src_path,
                workdir=job.workdir,
                opt=job.opt,
                python=self.bot.python or sys.executable,
                hard_timeout=float(self.bot.cfg["job_timeout_seconds"]),
                on_line=job.consume_line,
                cancel_event=job.cancel_event,
            )
        finally:
            pump.cancel()
            try:
                await pump
            except (asyncio.CancelledError, Exception):
                pass

        job.result = res
        if res.ok:
            self.done_count += 1
        else:
            self.failed_count += 1
        await self.bot.deliver(job, res)
        log.info("任务 %s 结束 ok=%s 模式=%s 用时=%.1fs 输出=%s",
                 job.id, res.ok, res.mode, res.elapsed, res.output)

    async def _progress_pump(self, job: Job) -> None:
        interval = max(3, int(self.bot.cfg["progress_interval_seconds"]))
        while True:
            await asyncio.sleep(interval)
            try:
                await self._render(job)
            except asyncio.CancelledError:
                raise
            except Exception:
                log.debug("刷新进度失败", exc_info=True)

    async def _render(self, job: Job) -> None:
        if not job.status_msg:
            return
        embed = progress_embed(self.bot, job)
        try:
            await job.status_msg.edit(embed=embed)
        except discord.NotFound:
            job.status_msg = None
        except discord.HTTPException as exc:
            log.debug("编辑进度消息失败: %s", exc)


# --------------------------------------------------------------------------
# 界面（embed / view）
# --------------------------------------------------------------------------

def _bar(ratio: float, width: int = 14) -> str:
    ratio = max(0.0, min(1.0, ratio))
    filled = int(ratio * width)
    return "▓" * filled + "░" * (width - filled)


def _fmt_dur(seconds: float) -> str:
    seconds = int(max(0, seconds))
    m, s = divmod(seconds, 60)
    if m >= 60:
        h, m = divmod(m, 60)
        return f"{h}:{m:02d}:{s:02d}"
    return f"{m:02d}:{s:02d}"


def progress_embed(bot: "DeobfBot", job: Job) -> discord.Embed:
    limit = float(bot.cfg["job_timeout_seconds"])
    ratio = job.elapsed / limit if limit else 0.0
    e = discord.Embed(
        title=f"🛠 任务 {job.id}",
        description=f"{job.stage}\n{job.detail}" if job.detail else job.stage,
        colour=0x5865F2,
        timestamp=datetime.now(timezone.utc),
    )
    e.add_field(name="源文件", value=job.source_name[:100], inline=True)
    e.add_field(name="版本", value="自动识别", inline=True)
    e.add_field(name="进度", value=f"`{_bar(ratio)}` {int(ratio * 100)}%\n"
                                   f"已用 {_fmt_dur(job.elapsed)} / 上限 {_fmt_dur(limit)}",
                inline=False)
    if job._last_error:
        e.add_field(name="最近警告", value=f"`{job._last_error[:200]}`", inline=False)
    e.set_footer(text=f"提交者 {job.user_name}")
    return e


def result_embed(bot: "DeobfBot", job: Job, res: Result) -> discord.Embed:
    if not res.ok:
        e = discord.Embed(
            title=f"❌ 任务 {job.id} 失败",
            description=res.note or "解混淆器没有产出结果，日志见附件。",
            colour=0xED4245,
        )
    else:
        mode = {"devirt": "✅ 完整反虚拟化", "trace": "🟡 行为追踪（只含跑到的分支）"}
        e = discord.Embed(
            title=f"✅ 任务 {job.id} 完成",
            description=res.note or None,
            colour=0x57F287,
        )
        e.add_field(name="引擎", value=res.engine or "-", inline=True)
        e.add_field(name="输出类型", value=mode.get(res.mode, res.mode), inline=True)
        e.add_field(name="用时", value=f"{res.elapsed:.1f} 秒", inline=True)
        e.add_field(name="结果大小", value=f"{res.size_bytes / 1024:.1f} KB / "
                                           f"{res.line_count} 行", inline=True)
        e.add_field(name="源文件", value=job.source_name, inline=True)
    if res.warnings:
        shown = res.warnings[:4]
        e.add_field(name="警告", value="\n".join(f"• {w[:150]}" for w in shown)[:1000],
                    inline=False)
    if res.stages:
        e.add_field(name="耗时阶段", value="\n".join(f"• {s[:120]}" for s in res.stages[-4:])[:1000],
                    inline=False)
    e.set_footer(text=f"{job.user_name} · 输出由自动化解混淆工具生成，可能不完整")
    return e


class CancelView(discord.ui.View):
    """任务进行中可以点按钮取消。"""

    def __init__(self, bot: "DeobfBot", job: Job) -> None:
        # 按钮只在任务可能还在跑的时候有效
        super().__init__(timeout=float(bot.cfg["job_timeout_seconds"]) + 120)
        self.bot = bot
        self.job = job

    @discord.ui.button(label="取消任务", style=discord.ButtonStyle.danger, emoji="🛑")
    async def cancel(self, interaction: discord.Interaction, button: discord.ui.Button) -> None:
        job = self.job
        owner_ok = interaction.user.id == job.user_id
        moderator = bool(interaction.user.guild_permissions.manage_messages) \
            if isinstance(interaction.user, discord.Member) else False
        if not (owner_ok or moderator):
            await interaction.response.send_message("只有提交者或管理员能取消。", ephemeral=True)
            return
        if job.result is not None:
            await interaction.response.send_message("任务已经结束了。", ephemeral=True)
            return

        job.cancel_event.set()          # 正在跑的会立刻被杀掉，还在排队的会被 worker 跳过
        button.disabled = True
        button.label = "正在取消…"
        await interaction.response.edit_message(view=self)


class ResendView(discord.ui.View):
    """结果消息上的"重新发送结果"按钮（重启后依然可用）。"""

    def __init__(self, bot: "DeobfBot") -> None:
        super().__init__(timeout=None)
        self.bot = bot

    @discord.ui.button(label="重新发送结果", style=discord.ButtonStyle.secondary,
                       emoji="📎", custom_id="deobf:resend")
    async def resend(self, interaction: discord.Interaction, button: discord.ui.Button) -> None:
        await self.bot.resend_result(interaction)


# --------------------------------------------------------------------------
# 机器人
# --------------------------------------------------------------------------

class DeobfBot(discord.Client):
    def __init__(self, cfg: dict, deobf_dir: Path) -> None:
        intents = discord.Intents.default()
        intents.message_content = True
        intents.guild_messages = True
        intents.dm_messages = bool(cfg["allow_dm"])
        super().__init__(intents=intents, activity=discord.Activity(
            type=discord.ActivityType.watching, name=".deobf | /deobf"))
        self.cfg = cfg
        self.deobf_dir = deobf_dir
        self.python = cfg.get("python") or sys.executable
        self.tree = app_commands.CommandTree(self)
        self.job_queue = JobQueue(self)
        self._cooldown: dict[int, float] = {}
        self.started_at = time.time()
        self.work_root = HERE / "work"
        self.work_root.mkdir(exist_ok=True)
        self.resend_view = ResendView(self)     # 结果消息上的"重新发送"按钮
        self._register_slash()

    # ---------------- 生命周期 ----------------
    async def setup_hook(self) -> None:
        await self.job_queue.start()
        self.add_view(self.resend_view)          # 持久化按钮，重启后仍可用
        guild = discord.Object(id=int(self.cfg["sync_guild_id"])) if self.cfg["sync_guild_id"] else None
        try:
            if guild:
                self.tree.copy_global_to(guild=guild)
                await self.tree.sync(guild=guild)
            else:
                await self.tree.sync()
            log.info("斜杠命令已同步（%s）", "当前服务器" if guild else "全局，可能延迟 1 小时")
        except discord.HTTPException as exc:
            log.warning("斜杠命令同步失败：%s", exc)

    async def close(self) -> None:
        await self.job_queue.stop()
        await super().close()

    async def on_ready(self) -> None:
        log.info("登录成功：%s（%s）| 解混淆器：%s", self.user, self.user.id, self.deobf_dir)

    # ---------------- 反应：用户指令上的加载 / 完成标记 ----------------
    async def _react(self, message: "discord.Message | None", emoji: str) -> bool:
        if message is None:
            return False
        try:
            await message.add_reaction(emoji)
            return True
        except (discord.Forbidden, discord.NotFound, discord.HTTPException) as exc:
            log.debug("加反应 %s 失败：%s", emoji, exc)
            return False

    async def _unreact(self, message: "discord.Message | None", emoji: str) -> None:
        if message is None:
            return
        try:
            await message.remove_reaction(emoji, self.user)
        except (discord.Forbidden, discord.NotFound, discord.HTTPException) as exc:
            log.debug("去掉反应 %s 失败：%s", emoji, exc)

    async def _swap_reaction(self, message: "discord.Message | None",
                             old: str, new: str) -> None:
        """把加载中的反应换成结果反应（没有权限时安静跳过）。"""
        await self._unreact(message, old)
        await self._react(message, new)

    # ---------------- 权限 / 限额 ----------------
    def allowed(self, user_id: int, guild_id: int | None) -> str:
        users = self.cfg["allowed_user_ids"] or []
        guilds = self.cfg["allowed_guild_ids"] or []
        if users and user_id not in users:
            return "你不在允许使用名单里。"
        if guilds and (guild_id is None or guild_id not in guilds):
            return "这个服务器没被授权使用。"
        if guild_id is None and not self.cfg["allow_dm"]:
            return "私聊不可用，请在服务器里使用。"
        return ""

    def cooldown_left(self, user_id: int) -> int:
        cd = float(self.cfg["user_cooldown_seconds"] or 0)
        if cd <= 0:
            return 0
        last = self._cooldown.get(user_id, 0.0)
        left = cd - (time.time() - last)
        return int(left) if left > 0 else 0

    # ---------------- 提交任务 ----------------
    async def submit(self, *, channel: discord.abc.Messageable, user: discord.abc.User,
                     guild_id: int | None, attachment: discord.Attachment,
                     opt: Options, msg: discord.Message | None = None,
                     ) -> tuple[str, Job | None]:
        """建工作目录、下载附件、入队。返回 (提示信息, job)。"""
        if self.job_queue.queue.full():
            return f"队列已满（{self.cfg['queue_size']}），稍后再试。", None

        if not attachment.size:
            return "这个附件是空的（0 字节）。", None

        max_in = float(self.cfg["max_input_mb"]) * 1024 * 1024
        if attachment.size and attachment.size > max_in:
            return (f"文件太大：{attachment.size / 1048576:.1f} MB，"
                    f"上限 {self.cfg['max_input_mb']} MB。"), None

        job_id = self.job_queue.new_id()
        workdir = self.work_root / f"job-{job_id}"
        workdir.mkdir(parents=True, exist_ok=True)
        try:
            data = await attachment.read()
        except discord.HTTPException as exc:
            return f"下载附件失败：{exc}", None

        # 注意：Path / "upload" 之后不能再和字符串相加；扩展名也顺手做个白名单
        suffix = Path(attachment.filename).suffix.lower()
        if not re.fullmatch(r"\.[A-Za-z0-9]{1,10}", suffix):
            suffix = ".lua"
        raw = workdir / ("upload" + suffix)
        raw.write_bytes(data)
        src = prepare_input(raw, workdir, keep_name=attachment.filename)
        try:
            raw.unlink()
        except OSError:
            pass

        job = Job(
            id=job_id,
            user_id=user.id,
            user_name=str(user),
            guild_id=guild_id,
            channel=channel,
            source_name=attachment.filename,
            opt=opt,
            workdir=workdir,
            src_path=src,
            msg=msg,
        )
        self._cooldown[user.id] = time.time()
        await self.job_queue.queue.put(job)
        return "", job

    async def post_status(self, job: Job, note: str = "") -> None:
        embed = progress_embed(self, job)
        if note:
            embed.description = f"{note}\n{embed.description or ''}"
        try:
            job.status_msg = await job.channel.send(embed=embed, view=CancelView(self, job))
        except discord.HTTPException as exc:
            log.warning("发送状态消息失败：%s", exc)

    # ---------------- 交付结果 ----------------
    def _out_name(self, job: Job, res: Result) -> str:
        stem = Path(job.source_name).stem or "result"
        stem = re.sub(r"[^\w\-.]+", "_", stem)[:60]
        return f"{stem}.{'trace.luau' if res.mode == 'trace' else 'deob.lua'}"

    def _extra_name(self, job: Job, res: Result, extra: Path) -> str:
        """深度清单也用和主结果一样的名字，同一个任务的文件排在一起不会乱。"""
        main = self._out_name(job, res)
        tail = extra.name.split("input.deob.", 1)[-1]
        return f"{Path(main).stem}.{tail}"

    def _maybe_zip(self, path: Path, extra: list[Path]) -> Path:
        zip_path = path.with_suffix(path.suffix + ".zip")
        with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as z:
            z.write(path, path.name)
            for p in extra:
                if p.is_file():
                    z.write(p, p.name)
        return zip_path

    async def deliver(self, job: Job, res: Result) -> None:
        view = self.resend_view
        embed = result_embed(self, job, res)
        log_file = job.workdir / "log.txt"
        limit = float(self.cfg["max_upload_mb"]) * 1024 * 1024
        files: list[discord.File] = []

        if res.ok and res.output and res.output.is_file():
            payload = res.output
            # 超过上传上限、或用户要了 debug（中间文件），打包成 zip
            if payload.stat().st_size > limit or job.opt.debug:
                extra = [p for p in res.output.parent.iterdir()
                         if p.is_file() and p != res.output] if job.opt.debug else []
                if log_file.is_file():
                    extra.append(log_file)
                payload = self._maybe_zip(res.output, extra)
            if payload.stat().st_size > limit:
                preview = res.output.read_bytes()[:400_000]
                files.append(discord.File(io.BytesIO(preview),
                                          filename=self._out_name(job, res) + ".preview.txt"))
                embed.add_field(
                    name="注意",
                    value=f"结果 {res.output.stat().st_size / 1048576:.1f} MB 超过上传上限，"
                          f"这里只发了前 400 KB 预览；完整文件在服务器上：\n`{res.output}`",
                    inline=False)
            else:
                files.append(discord.File(payload, filename=payload.name))

            # ---- 深度清单：参考清单 / 逐条反汇编，跟着结果一起发 ----
            sent_extra: list[str] = []
            for extra in (res.extras or []):
                if len(files) >= 5:      # 主结果 + 4 个附件（Discord 上限 10）
                    break
                try:
                    if not extra.is_file():
                        continue
                    fname = self._extra_name(job, res, extra)
                    if extra.stat().st_size > limit:
                        head = extra.read_text(encoding="utf-8", errors="replace")[:200_000]
                        files.append(discord.File(
                            io.BytesIO(head.encode("utf-8")),
                            filename=Path(fname).stem + ".preview.txt"))
                    else:
                        files.append(discord.File(extra, filename=fname))
                    sent_extra.append(fname)
                except (OSError, discord.HTTPException):
                    continue
            if sent_extra:
                embed.add_field(
                    name="另附",
                    value="\n".join(f"• `{n}`" for n in sent_extra)
                          + "\n反虚拟化没走到的地方，可以拿这两份对照着看。",
                    inline=False)
        else:
            if res.output and not res.output.is_file():
                embed.add_field(name="注意", value="没有找到结果文件（可能被 engine 删掉了）", inline=False)
            if log_file.is_file():
                tail = log_file.read_text(encoding="utf-8", errors="replace")[-60_000:]
                files.append(discord.File(io.BytesIO(tail.encode("utf-8")),
                                          filename=f"job-{job.id}.log.txt"))

        try:
            if job.status_msg:
                await job.status_msg.edit(embed=embed, view=view)
                if files:
                    await job.status_msg.reply(files=files, mention_author=False)
            else:
                await job.channel.send(embed=embed, view=view, files=files)
        except discord.HTTPException as exc:
            log.warning("发送结果失败：%s", exc)
            try:
                await job.channel.send(f"任务 {job.id} 的结果发送失败（{exc}），"
                                       f"文件在服务器：`{res.output}`")
            except discord.HTTPException:
                pass

        # 用户那条指令上的 ⏳ 换成 ✅ / ❌
        await self._swap_reaction(job.msg, LOADING_EMOJI,
                                  DONE_EMOJI if res.ok else FAIL_EMOJI)

        # keep_work=false 时不留上传的原脚本（结果和日志保留，方便重发/排查）
        if not self.cfg.get("keep_work", True):
            # 深度捕获的工作目录（动辄 1～2 MB 的 protos.json）也一并清掉
            for junk in list(job.workdir.glob(".*_work")) + [job.workdir / "deep"]:
                try:
                    if junk.is_dir():
                        shutil.rmtree(junk, ignore_errors=True)
                except OSError:
                    pass
            for old in list(job.workdir.glob("input.*")) + [job.workdir / "upload.lua"]:
                if old in (res.output,):
                    continue
                try:
                    old.unlink()
                except OSError:
                    pass

    async def resend_result(self, interaction: discord.Interaction) -> None:
        """按状态消息的 footer 找回任务号，重发结果文件。"""
        msg = interaction.message
        job_id = None
        if msg.embeds:
            m = re.search(r"任务\s*(\d{4}-\d{3})", msg.embeds[0].title or "")
            if m:
                job_id = m.group(1)
        if job_id is None:
            await interaction.response.send_message("找不到任务编号，无法重发。", ephemeral=True)
            return
        workdir = self.work_root / f"job-{job_id}"
        outdir = workdir / "out"
        files = sorted(outdir.glob("*")) if outdir.is_dir() else []
        if not files:
            await interaction.response.send_message(
                f"任务 {job_id} 的结果文件已经不在服务器上了。", ephemeral=True)
            return
        await interaction.response.defer()
        payload = [discord.File(p, filename=p.name) for p in files[:5]]
        await interaction.followup.send(files=payload)

    # ---------------- 消息指令 ----------------
    async def on_message(self, message: discord.Message) -> None:
        if message.author.bot:
            return
        parsed = parse_command(message.content, self.cfg)
        if parsed is None:
            return

        # 认出是我们的指令：先在这条消息上挂一个"加载中"反应
        await self._react(message, LOADING_EMOJI)

        if parsed.want_help or (parsed.opt is None and not parsed.error):
            await message.reply(HELP_TEXT, mention_author=False)
            await self._unreact(message, LOADING_EMOJI)     # 帮助不是任务，收掉反应
            return
        if parsed.error:
            await message.reply(f"❌ {parsed.error}", mention_author=False)
            await self._swap_reaction(message, LOADING_EMOJI, FAIL_EMOJI)
            return

        reason = self.allowed(message.author.id, message.guild.id if message.guild else None)
        if reason:
            await message.reply(f"🚫 {reason}", mention_author=False)
            await self._swap_reaction(message, LOADING_EMOJI, FAIL_EMOJI)
            return

        attachment = self._pick_attachment(message)
        if attachment is None:
            await message.reply(
                "没有找到脚本附件：把被保护的 `.lua` / `.luau` / `.txt` 和 `.deobf` "
                "放在同一条消息里（`.help` 看指令）。", mention_author=False)
            await self._swap_reaction(message, LOADING_EMOJI, FAIL_EMOJI)
            return

        left = self.cooldown_left(message.author.id)
        if left:
            await message.reply(f"⏳ 冷却中，还要等 {left} 秒。", mention_author=False)
            await self._swap_reaction(message, LOADING_EMOJI, FAIL_EMOJI)
            return

        assert parsed.opt is not None
        err, job = await self.submit(channel=message.channel, user=message.author,
                                     guild_id=message.guild.id if message.guild else None,
                                     attachment=attachment, opt=parsed.opt, msg=message)
        if err or job is None:
            await message.reply(f"❌ {err}", mention_author=False)
            await self._swap_reaction(message, LOADING_EMOJI, FAIL_EMOJI)
            return
        await self.post_status(job, note=f"已收到 `{attachment.filename}`，队列位置 "
                                         f"#{self.job_queue.depth}")
        # 之后的进度由 deliver() 把 ⏳ 换成 ✅ / ❌

    @staticmethod
    def _pick_attachment(message: discord.Message) -> discord.Attachment | None:
        if not message.attachments:
            return None
        ok = (".lua", ".luau", ".txt", ".lph", ".luraph", "")
        for att in message.attachments:
            if Path(att.filename).suffix.lower() in ok:
                return att
        return message.attachments[0]

    # ---------------- 斜杠命令 ----------------
    def _register_slash(self) -> None:
        bot = self

        @self.tree.command(name="deobf", description="上传被 Luraph 保护的脚本，自动识别版本并解混淆")
        @app_commands.describe(file="被保护的脚本（.lua / .luau / .txt）")
        async def deobf_cmd(interaction: discord.Interaction, file: discord.Attachment) -> None:
            reason = bot.allowed(interaction.user.id,
                                 interaction.guild_id if interaction.guild else None)
            if reason:
                await interaction.response.send_message(f"🚫 {reason}", ephemeral=True)
                return
            left = bot.cooldown_left(interaction.user.id)
            if left:
                await interaction.response.send_message(f"⏳ 冷却中，还要等 {left} 秒。",
                                                        ephemeral=True)
                return
            opt = Options(
                version="auto",                 # 版本一律自动识别
                harness_timeout=int(bot.cfg["harness_timeout"]),
                budget=int(bot.cfg["time_budget"]),
                rounds=int(bot.cfg["devirt_rounds"]),
                max_runs=int(bot.cfg["max_runs"]),
            )
            await interaction.response.defer(ephemeral=bool(bot.cfg["ephemeral_results"]))
            err, job = await bot.submit(
                channel=interaction.channel, user=interaction.user,
                guild_id=interaction.guild_id, attachment=file, opt=opt)
            if err or job is None:
                await interaction.followup.send(f"❌ {err}")
                return
            await bot.post_status(job, note=f"来自 {interaction.user.mention} 的请求")

        @self.tree.command(name="help", description="显示指令列表")
        async def help_cmd(interaction: discord.Interaction) -> None:
            await interaction.response.send_message(HELP_TEXT, ephemeral=True)

        @self.tree.command(name="stats", description="队列与运行状态")
        async def stats_cmd(interaction: discord.Interaction) -> None:
            q = bot.job_queue
            up = _fmt_dur(time.time() - bot.started_at)
            e = discord.Embed(title="📊 状态", colour=0x5865F2)
            e.add_field(name="排队中", value=str(q.queue.qsize()), inline=True)
            e.add_field(name="进行中", value=str(len(q.running)), inline=True)
            e.add_field(name="已完成", value=str(q.done_count), inline=True)
            e.add_field(name="失败", value=str(q.failed_count), inline=True)
            e.add_field(name="并发上限", value=str(bot.cfg["max_concurrent_jobs"]), inline=True)
            e.add_field(name="运行时长", value=up, inline=True)
            e.add_field(name="解混淆器", value=f"`{bot.deobf_dir}`", inline=False)
            running = ", ".join(f"{j.id} {j.user_name}" for j in q.running.values()) or "—"
            e.add_field(name="当前任务", value=running, inline=False)
            await interaction.response.send_message(embed=e)


# --------------------------------------------------------------------------
# 入口
# --------------------------------------------------------------------------

def preflight(cfg: dict) -> tuple[Path | None, list[str]]:
    """检查配置和解混淆器环境。返回 (deobf_dir, 问题列表)。"""
    problems: list[str] = []
    token = str(cfg.get("token") or "")
    if not token:
        problems.append("没有配置 token：在 config.json 里填 \"token\"，或设置环境变量 DISCORD_TOKEN。")
    # token 形状只提醒不拦：万一格式特殊但能用，不能因为我们猜错就不让启动

    deobf_dir = None
    try:
        deobf_dir = find_deobf_dir(cfg.get("deobf_dir") or None)
    except DeobfNotFound as exc:
        problems.append(str(exc))
        return None, problems

    env = check_environment(deobf_dir, cfg.get("python") or sys.executable)
    if not env["luau"]:
        problems.append(f"缺少 Luau 运行时：{deobf_dir / 'bin'}"
                        f"（Windows 一般自带 luau.exe；Linux/macOS 见 README）")
    if not env["luau_ast"]:
        problems.append("缺少 luau-ast（大脚本反虚拟化会失败）")
    if sys.version_info < (3, 10):
        problems.append(f"Python {sys.version.split()[0]} 太旧，需要 3.10+（建议 3.12/3.13）")
    return deobf_dir, problems


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="Luraph 解混淆 Discord 机器人")
    ap.add_argument("--config", default=str(HERE / "config.json"), help="配置文件路径")
    ap.add_argument("--check", action="store_true", help="只做环境自检，不连 Discord")
    args = ap.parse_args(argv)

    cfg = load_config(Path(args.config))
    setup_logging(HERE / "logs")

    deobf_dir, problems = preflight(cfg)

    if args.check:
        print("=" * 64)
        print("环境自检")
        print("=" * 64)
        print(f"Python      : {sys.version.split()[0]}  ({sys.executable})")
        print(f"配置文件    : {args.config}")
        print(f"解混淆器    : {deobf_dir or '未找到'}")
        if deobf_dir:
            env = check_environment(deobf_dir, cfg.get("python") or sys.executable)
            print(f"luau        : {env['luau'] or '缺失'}")
            print(f"luau-ast    : {env['luau_ast'] or '缺失'}")
        token_ok = TOKEN_SHAPE.match(str(cfg.get("token") or "")) is not None
        print(f"token       : {'已配置' if cfg.get('token') else '未配置'}"
              f"{'' if (not cfg.get('token') or token_ok) else '（格式看着不像 Bot Token）'}")
        print(f"并发/队列   : {cfg['max_concurrent_jobs']} / {cfg['queue_size']}")
        print(f"工作目录    : {HERE / 'work'}")
        print("-" * 64)
        if problems:
            for p in problems:
                print(f"[x] {p}")
            return 1
        print("[✓] 一切正常，可以启动：双击 run.bat（或 python bot.py）")
        return 0

    for p in problems:
        log.error(p)
    if problems:
        return 1
    if not TOKEN_SHAPE.match(str(cfg.get("token") or "")):
        log.warning("token 看起来不像 Bot Token（一般形如 xxx.yyy.zzz，在开发者后台 Bot 页面点 "
                    "Reset Token 复制；别填 Application ID 或 Client Secret）。"
                    "如果登录失败，先来这儿检查。")

    assert deobf_dir is not None
    bot = DeobfBot(cfg, deobf_dir)
    try:
        bot.run(cfg["token"], log_handler=None)
    except discord.LoginFailure:
        log.error("登录失败：token 不对（也可能被重置过）。到开发者后台 Bot 页面点 Reset Token，"
                  "复制新 token 填进 config.json 的 \"token\"，注意别带引号和空格。")
        return 1
    except discord.PrivilegedIntentsRequired:
        log.error("Discord 拒绝了连接：机器人后台没开 Message Content Intent。"
                  "打开 https://discord.com/developers/applications → 选中你的应用 → Bot → "
                  "Privileged Gateway Intents → 打开 MESSAGE CONTENT INTENT → Save，然后重启机器人。")
        return 1
    except KeyboardInterrupt:
        log.info("已停止")
    except Exception as exc:                       # 网络 / DNS / 代理 / 其它运行时问题
        net = False
        try:
            import aiohttp
            net = isinstance(exc, (aiohttp.ClientError, OSError))
        except ImportError:
            net = isinstance(exc, OSError)
        if net:
            log.error("连不上 Discord（网络 / DNS / 代理问题）：%s", exc)
            log.error("检查：能正常打开 discord.com 吗？公司网络/代理可能需要额外配置。")
        else:
            log.exception("运行时出错，程序要退出了：%s", exc)
        return 1
    return 0


if __name__ == "__main__":
    # 双击运行：出错/结束时停一下，别让窗口一闪就没
    raise SystemExit(run_cli(main))
