#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
bot.py 功能自检（不连 Discord）
==============================

用假的消息/频道对象把整条链路跑一遍，检查：

  1. 指令解析：`.deobf` / `.help` / 老写法 `.deobf/14.7` / 已移除的 trace/strings/debug
  2. 加载反应：用户指令消息上先加 ⏳，完成后换成 ✅（失败换 ❌，help 直接收掉）
  3. 任务编号：XXXX-XXX 格式、不重复、工作目录名一致
  4. 水印：交付的主 Lua 结果第一行是 `-- deobf by https://discord.gg/ck3k7nAVS`
  5. 结果回执只发送一个主 Lua 文件，不发送日志 / 深度诊断附件

用法（需要 bin/ 里有能用的 luau / luau-ast）：
    python selftest_ui.py [样本文件]
默认样本：vendor/luraph-deobf/Deobfuscator/samples/v14/v14.8.txt（快，~1 秒）
"""
from __future__ import annotations

import asyncio
import re
import shutil
import sys
import tempfile
import zipfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import bot as botmod  # noqa: E402   （控制台/编码兜底在 bot 里已生效）
try:                                          # winpause.py 不在也能跑
    from winpause import run_cli  # noqa: E402
except ImportError:  # pragma: no cover
    def run_cli(fn, argv=None) -> int:
        return int(fn())
from deobf_runner import WATERMARK, find_deobf_dir  # noqa: E402

FAILED: list[str] = []
PASSED = 0


def check(ok: bool, what: str, extra: str = "") -> None:
    global PASSED
    if ok:
        PASSED += 1
        print(f"  [✓] {what}")
    else:
        FAILED.append(what)
        print(f"  [x] {what} {extra}")


# --------------------------------------------------------------------------
# 假的 Discord 对象
# --------------------------------------------------------------------------

class FakeUser:
    def __init__(self, name="tester", uid=4242, is_bot=False):
        self.name = name
        self.id = uid
        self.bot = is_bot
        self.display_name = name

    def __str__(self):
        return self.name


class FakeAttachment:
    def __init__(self, path: Path, filename: str | None = None):
        self._p = Path(path)
        self.filename = filename or self._p.name
        self.size = self._p.stat().st_size

    async def read(self) -> bytes:
        return self._p.read_bytes()


class FakeMessage:
    """既能当"用户发的指令"，也能当"机器人发出去的消息"。"""

    def __init__(self, content: str = "", author=None, attachments=(), channel=None):
        self.content = content
        self.author = author or FakeUser(is_bot=True)
        self.attachments = list(attachments)
        self.channel = channel
        self.guild = None
        self.id = 1
        self.replies: list[str] = []
        self.reactions: list[str] = []
        self.edits: int = 0
        self.embeds: list = []
        self.sent: list[dict] = []

    # 用户消息接口
    async def reply(self, content=None, **kw):
        self.replies.append(content or "")
        self.reply_files = kw.get("files") or []      # 结果文件是 reply 出来的
        return FakeMessage(channel=self.channel)

    async def add_reaction(self, emoji):
        self.reactions.append(emoji)

    async def remove_reaction(self, emoji, user):
        self.reactions.append("-" + emoji)

    # 机器人消息接口
    async def edit(self, **kw):
        self.edits += 1
        if kw.get("embed") is not None:
            self.embeds = [kw["embed"]]
        return self

    async def send(self, content=None, **kw):
        self.sent.append({"content": content, "files": kw.get("files") or [],
                          "embed": kw.get("embed")})
        m = FakeMessage(channel=self.channel)
        m.embeds = [kw["embed"]] if kw.get("embed") is not None else []
        m.files = kw.get("files") or []
        return m


class FakeChannel(FakeMessage):
    def __init__(self):
        super().__init__()
        self.messages: list[FakeMessage] = []

    async def send(self, content=None, **kw):
        m = await super().send(content, **kw)
        self.messages.append(m)
        return m


# --------------------------------------------------------------------------

def make_bot(work_root: Path, sample_mb: int = 25):
    deobf_dir = find_deobf_dir(str(HERE / "vendor" / "luraph-deobf" / "Deobfuscator" / "deobf"))
    cfg = dict(botmod.DEFAULTS)
    cfg.update({
        "token": "test-token-not-used",
        "user_cooldown_seconds": 0,
        "max_concurrent_jobs": 1,
        "progress_interval_seconds": 3,
        "harness_timeout": 90,
        "time_budget": 20,
        "job_timeout_seconds": 300,
    })
    b = botmod.DeobfBot(cfg, deobf_dir)
    b.work_root = work_root                       # 别污染项目的 work/
    # remove_reaction(emoji, self.user) 要用到；discord.Client.user 是只读属性，
    # 直接塞底层连接对象（自检不联网，不影响真实运行）
    b._connection.user = FakeUser("deobf-bot", 999, is_bot=True)
    return b


async def drain(b: "botmod.DeobfBot", timeout: float = 420.0) -> None:
    waited = 0.0
    while b.job_queue.depth and waited < timeout:
        await asyncio.sleep(0.25)
        waited += 0.25


def titles(channel: FakeChannel) -> list[str]:
    out = []
    for m in channel.messages:
        for e in (m.embeds or []):
            if e.title:
                out.append(e.title)
    return out


async def main() -> int:
    sample = Path(sys.argv[1]) if len(sys.argv) > 1 else (
        HERE / "vendor/luraph-deobf/Deobfuscator/samples/v14/v14.8.txt")
    print("=" * 64)
    print("bot.py 功能自检")
    print("=" * 64)
    print(f"样本: {sample}")

    # ---- 1) 指令解析 ----
    print("\n[1] 指令解析")
    P = botmod.parse_command
    cfg = botmod.DEFAULTS
    check(P("hello", cfg) is None, "普通消息被忽略")
    r = P(".deobf", cfg)
    check(r is not None and r.opt is not None and r.opt.version == "auto", "`.deobf` -> 自动识别")
    r = P(".deobf/14.7", cfg)
    check(r is not None and r.opt is not None, "老写法 `.deobf/14.7` 仍可用（忽略版本）")
    for c in (".help", "!help", ".deobf help"):
        r = P(c, cfg)
        check(r is not None and r.want_help, f"`{c}` -> 帮助")
    for flag in ("trace", "strings", "debug"):
        r = P(f".deobf {flag}", cfg)
        check(r is not None and "已经移除" in r.error, f"`.deobf {flag}` 给出『已移除』提示")
    r = P(".deobf 讲不通的参数", cfg)
    check(r is not None and r.error and ".help" in r.error, "未知参数提示指向 .help")
    check(WATERMARK not in botmod.HELP_TEXT, "帮助里不出现水印（保持极简）")
    check(botmod.HELP_TEXT.count("\n") <= 5, "帮助是极简列表", repr(botmod.HELP_TEXT))

    # ---- 2) 任务编号 ----
    print("\n[2] 任务编号格式")
    work = Path(tempfile.mkdtemp(prefix="ui-selftest-"))
    b = make_bot(work)
    selector = work / "result-filter"
    selector.mkdir()
    main_lua = selector / "sample.deob.lua"
    trace_lua = selector / "sample.trace.luau"
    main_lua.write_text("return 1\n", encoding="utf-8")
    trace_lua.write_text("return 2\n", encoding="utf-8")
    (selector / "sample.deob.部分反编译.lua").write_text("return 3\n", encoding="utf-8")
    (selector / "job.log.txt").write_text("diagnostic\n", encoding="utf-8")
    check(botmod.primary_lua_result(selector) == main_lua,
          "结果筛选优先返回主 Lua，忽略诊断文件")
    main_lua.unlink()
    check(botmod.primary_lua_result(selector) == trace_lua,
          "无静态文件时可回传行为追踪 Lua")
    zip_path = botmod.DeobfBot._maybe_zip(None, trace_lua)
    with zipfile.ZipFile(zip_path) as archive:
        check(archive.namelist() == [trace_lua.name], "大结果 zip 只包含主 Lua 文件")
    zip_path.unlink()
    ids = {b.job_queue.new_id() for _ in range(300)}
    check(len(ids) == 300, "编号不重复")
    check(all(re.fullmatch(r"\d{4}-\d{3}", i) for i in ids), "编号形如 XXXX-XXX",
          repr(sorted(ids)[:3]))

    # ---- 3) 帮助指令的反应 ----
    print("\n[3] 帮助指令：加载反应加完就收掉")
    ch = FakeChannel()
    user = FakeUser()
    msg = FakeMessage(".help", author=user, channel=ch)
    await b.on_message(msg)
    check(msg.reactions == ["⏳", "-⏳"], "help 的反应序列 ⏳ -> 收掉", repr(msg.reactions))
    check(msg.replies and "指令" in msg.replies[0], "help 回复了指令表")

    # ---- 4) 已移除参数：❌ 反应 ----
    print("\n[4] 已移除参数：⏳ -> ❌")
    msg = FakeMessage(".deobf debug", author=user, channel=ch)
    await b.on_message(msg)
    check(msg.reactions == ["⏳", "-⏳", "❌"], "反应序列 ⏳ -> ❌", repr(msg.reactions))
    check(msg.replies and "已经移除" in msg.replies[0], "回复提示已移除")

    # ---- 5) 没有附件：❌ 反应 ----
    msg = FakeMessage(".deobf", author=user, channel=ch)
    await b.on_message(msg)
    check(msg.reactions == ["⏳", "-⏳", "❌"], "无附件也换 ❌", repr(msg.reactions))

    # ---- 6) 真跑一次解混淆 ----
    print("\n[5] 端到端：.deobf + 样本文件")
    if not sample.is_file():
        check(False, f"样本不存在：{sample}")
    else:
        await b.job_queue.start()
        msg = FakeMessage(".deobf", author=user, channel=ch,
                          attachments=[FakeAttachment(sample, "myscript.txt")])
        await b.on_message(msg)
        check(msg.reactions[:1] == ["⏳"], "指令消息立刻加了 ⏳")
        if msg.replies:
            check("没有找到脚本附件" not in msg.replies[0], "附件被接受", repr(msg.replies[0]))
        await drain(b)
        await asyncio.sleep(0.6)
        if b.job_queue.depth:
            logs = sorted(work.glob("job-*/log.txt"))
            if logs:
                print("     任务还没结束，日志尾部：")
                for ln in logs[-1].read_text(encoding="utf-8", errors="replace").splitlines()[-8:]:
                    print("       " + ln)

        check(msg.reactions == ["⏳", "-⏳", "✅"], "完成后 ⏳ -> ✅", repr(msg.reactions))
        check(b.job_queue.done_count == 1 and b.job_queue.failed_count == 0,
              "任务统计正确", f"完成 {b.job_queue.done_count} / 失败 {b.job_queue.failed_count}")
        t = titles(ch)
        check(any(re.fullmatch(r"✅ 任务 \d{4}-\d{3} 完成", x) for x in t),
              "回执标题为「✅ 任务 XXXX-XXX 完成」", repr(t))
        dirs = [p.name for p in work.glob("job-*")]
        check(len(dirs) == 1 and re.fullmatch(r"job-\d{4}-\d{3}", dirs[0]),
              "工作目录名带新编号", repr(dirs))
        outdir = work / dirs[0] / "out" if dirs else work / "missing"
        main_output = botmod.primary_lua_result(outdir)
        check(main_output is not None, "定位到主 Lua 结果（不选中间诊断文件）", str(main_output))
        if main_output:
            head = main_output.read_text(encoding="utf-8", errors="replace").splitlines()[:1]
            check(head and head[0] == f"-- {WATERMARK}", "结果文件第一行是水印", repr(head))
            body = main_output.read_text(encoding="utf-8", errors="replace")
            for bad in ("dsc.gg", "Devirtualized with", "gpt 5.6"):
                check(bad not in body, f"结果里没有解混淆器署名（{bad}）")
        # 交付时只发送主 Lua 结果，不发送日志、深度捕获、部分反编译或预览。
        delivered = [f for m in ch.messages
                     for f in (getattr(m, "files", []) or getattr(m, "reply_files", []))]
        fnames = [getattr(f, "filename", "") for f in delivered]
        check(len(delivered) == 1, "只回传一个结果文件", repr(fnames))
        check(bool(fnames) and fnames[0].endswith((".deob.lua", ".trace.luau", ".deob.lua.zip", ".trace.luau.zip")),
              "回传文件是主 Lua 脚本（或只含该脚本的 zip）", repr(fnames))
        check(not any(any(tag in n for tag in ("部分反编译", "参考清单", "反汇编", "preview", ".log"))
                      for n in fnames), "不回传诊断附件或截断预览", repr(fnames))
        emb = ch.messages[-1].embeds[0] if ch.messages and ch.messages[-1].embeds else None
        check(bool(emb) and not any(f.name == "另附" for f in emb.fields),
              "结果卡片不列出诊断附件")
        await b.job_queue.stop()

    # ---- 7) 水印幂等 & 保留正文 ----
    print("\n[6] 水印：幂等、不动正文")
    from deobf_runner import apply_watermark
    f = work / "wm.lua"
    f.write_text("-- Devirtualized with Luraph v14.8 engine\n\n-- [best effort] 说明\n\nlocal a = 1\n", encoding="utf-8")
    apply_watermark(f)
    once = f.read_text(encoding="utf-8")
    apply_watermark(f)
    twice = f.read_text(encoding="utf-8")
    check(once == twice, "重复调用不叠加")
    check("local a = 1" in once and "[best effort] 说明" in once, "正文和说明行都保留")
    check(once.startswith(f"-- {WATERMARK}\n"), "水印在最顶上")
    shutil.rmtree(work, ignore_errors=True)

    print("\n" + "=" * 64)
    if FAILED:
        print(f"自检失败 {len(FAILED)} 项 / 通过 {PASSED} 项")
        for x in FAILED:
            print("  [x]", x)
        return 1
    print(f"自检全部通过（{PASSED} 项）")
    return 0


def cli() -> int:
    """同步入口，交给 run_cli（双击时结束后不闪退）。"""
    try:
        return asyncio.run(main())
    except KeyboardInterrupt:
        return 130


if __name__ == "__main__":
    raise SystemExit(run_cli(cli))
