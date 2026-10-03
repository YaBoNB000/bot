#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
deobf_runner.py -- 对 KryptIT/luraph-v15-v14.x-deobfuscator 的无依赖封装层。

这一层只负责"怎么调用解混淆器"，不碰 Discord，所以可以单独用命令行调试：

    python deobf_runner.py sample.lua --version 14.7 --deobf-dir D:\\deob\\Deobfuscator\\deobf
    python deobf_runner.py sample.lua --version 15
    python deobf_runner.py sample.lua            # 自动检测

对应关系（来自仓库自身的 CLI）：
    v14.7 / v14.8 / v14.9  ->  cli.py --engine 14.x
    v15                    ->  deob.py --obfuscator luraph_v15
    认不出来 / 其它混淆器   ->  deob.py（generic：只出行为追踪）
"""
from __future__ import annotations

import asyncio
import os
import re
import shutil
import subprocess
import sys
import time
from dataclasses import dataclass, field
from pathlib import Path
from typing import Callable, Iterable, Sequence

# --------------------------------------------------------------------------
# 常量
# --------------------------------------------------------------------------

#: Luraph 头部横幅（v14.x / v15 都是这个格式）
BANNER_RE = re.compile(
    r"protected\s+using\s+Luraph\s+Obfuscator\s+v?(\d+(?:\.\d+)?)", re.I
)

#: v14 分支引擎对应的版本号
V14_VERSIONS = ("14.7", "14.8", "14.9")

#: 用户可选的版本 -> 内部归一化
VERSION_ALIASES = {
    "auto": "auto", "": "auto", "detect": "auto", "自动": "auto",
    "14": "14.7", "14.7": "14.7", "v14.7": "14.7", "147": "14.7",
    "14.8": "14.8", "v14.8": "14.8", "148": "14.8",
    "14.9": "14.9", "v14.9": "14.9", "149": "14.9",
    "15": "15", "v15": "15", "15.0": "15",
}

#: 行为追踪输出里的一句固定注释，用来判断这次只拿到了 trace
#: 结果文件顶部的水印（你自己的），引擎写出来的署名会被替换成它
WATERMARK = "deobf by https://discord.gg/ck3k7nAVS"

#: 驱动在"payload 由 VM 调度循环进入"时打的标记（v14.9 的引导布局）
V14_DISPATCH_LAYOUT = re.compile(r"v14\.9 layout")

#: 解混淆器自己会往结果文件里写的署名行，全部清掉
_CREDIT_PATTERNS = (
    re.compile(r"^--\s*Devirtualized with Luraph v[\d.]+ engine\s*$", re.I),
    re.compile(r"^--\s*Deobfuscated by .*on Discord\s*$", re.I),
    re.compile(r"^--\s*Why do i love gpt.*$", re.I),
    re.compile(r"^--\s*dsc\.gg/\S*\s*$", re.I),
    re.compile(r"^--\s*deobf by\s+https?://\S+\s*$", re.I),
)

TRACE_MARKERS = (
    "yeah this ran at runtime",
    "not gonna be full",
)

#: 子进程需要的关键文件（用来确认目录真的是解混淆器根目录）
_REQUIRED_FILES = ("harness.py", "deob.py", "cli.py")
_REQUIRED_DIRS = ("obfuscators",)


class DeobfNotFound(RuntimeError):
    """找不到解混淆器目录。"""


# --------------------------------------------------------------------------
# 选项 / 结果
# --------------------------------------------------------------------------

@dataclass
class Options:
    """一次解混淆任务的参数。"""

    version: str = "auto"          # auto | 14.7 | 14.8 | 14.9 | 15
    trace_only: bool = False       # 只要行为追踪（--no-devirt），快很多
    strings: bool = False          # 输出里额外带上脚本构造过的字符串
    debug: bool = False            # 保留全部中间文件
    harness_timeout: int = 150     # 单次运行的硬超时（秒）
    budget: int = 30               # 被追踪脚本的时间预算（秒）
    complete_v14: bool = True      # v14 用「完整配方」（最完整，代价是慢：14.7 约 8 分钟）
    rounds: int = 200              # 反虚拟化轮数上限
    max_runs: int = 12             # 陷阱重跑次数上限

    def normalized_version(self) -> str:
        key = (self.version or "auto").strip().lower()
        if key not in VERSION_ALIASES:
            raise ValueError(f"不支持的版本 {self.version!r}（可用：auto / 14.7 / 14.8 / 14.9 / 15）")
        return VERSION_ALIASES[key]


@dataclass
class Attempt:
    """一次尝试：用哪个引擎、哪个版本、是否只出行为追踪。"""

    kind: str          # v14 | v15 | other | generic
    version: str       # 14.7 / 14.8 / 14.9 / 15 / ""
    label: str         # 给人看的名字
    trace: bool = False


@dataclass
class Result:
    """一次解混淆任务的结果。"""

    ok: bool = False
    output: Path | None = None
    engine: str = ""               # 人类可读的引擎名，例如 "Luraph v14.7"
    mode: str = "devirt"           # devirt（完整反虚拟化） | trace（行为追踪）
    elapsed: float = 0.0
    returncode: int | None = None
    cancelled: bool = False
    timed_out: bool = False
    fallback_used: bool = False    # v14 首次失败后改用 --trace-fallback 重试成功
    log: str = ""
    warnings: list[str] = field(default_factory=list)
    stages: list[str] = field(default_factory=list)
    command: list[str] = field(default_factory=list)
    note: str = ""                 # 需要展示给用户的说明（例如"只拿到行为追踪"）
    extras: list[Path] = field(default_factory=list)   # 额外附件（反汇编清单 / 参考清单）

    @property
    def size_bytes(self) -> int:
        try:
            return self.output.stat().st_size if self.output and self.output.is_file() else 0
        except OSError:
            return 0

    @property
    def line_count(self) -> int:
        if not self.output or not self.output.is_file():
            return 0
        try:
            with self.output.open("rb") as fh:
                return sum(1 for _ in fh)
        except OSError:
            return 0


# --------------------------------------------------------------------------
# 定位解混淆器
# --------------------------------------------------------------------------

def _looks_like_deobf_dir(path: Path) -> bool:
    return (
        path.is_dir()
        and all((path / f).is_file() for f in _REQUIRED_FILES)
        and all((path / d).is_dir() for d in _REQUIRED_DIRS)
    )


def find_deobf_dir(explicit: str | os.PathLike | None = None,
                   extra_candidates: Iterable[str | os.PathLike] = ()) -> Path:
    """找到解混淆器根目录（内含 deob.py / cli.py / obfuscators/）。

    搜索顺序：显式指定 -> DEOBF_DIR 环境变量 -> 调用方给的候选 -> 常见位置。
    """
    candidates: list[Path] = []

    def push(p: str | os.PathLike | None) -> None:
        if not p:
            return
        candidates.append(Path(p).expanduser())

    push(explicit)
    push(os.environ.get("DEOBF_DIR"))
    for c in extra_candidates:
        push(c)

    here = Path(__file__).resolve().parent
    for base in (here, here.parent, Path.cwd()):
        # 随项目一起分发的布局：<项目>/vendor/luraph-deobf/Deobfuscator/deobf
        push(base / "vendor" / "luraph-deobf" / "Deobfuscator" / "deobf")
        push(base / "vendor" / "deobf")
        push(base / "deobf" / "Deobfuscator" / "deobf")
        push(base / "Deobfuscator" / "deobf")
        push(base / "deobf")
        push(base / "luraph-v15-v14.x-deobfuscator" / "Deobfuscator" / "deobf")
        # vendor/*/Deobfuscator/deobf 这种任意命名的下载目录
        vroot = base / "vendor"
        if vroot.is_dir():
            try:
                for child in sorted(vroot.iterdir()):
                    if child.is_dir():
                        push(child / "Deobfuscator" / "deobf")
                        push(child / "deobf")
            except OSError:
                pass

    seen: set[Path] = set()
    for cand in candidates:
        try:
            resolved = cand.resolve()
        except OSError:
            continue
        if resolved in seen:
            continue
        seen.add(resolved)
        if _looks_like_deobf_dir(resolved):
            return resolved

    raise DeobfNotFound(
        "找不到解混淆器目录（需要包含 deob.py / cli.py / obfuscators/ 的文件夹）。\n"
        "  1) 先运行 setup.ps1（Windows）或 setup.sh（Linux/macOS），或手动执行：\n"
        "     git clone https://github.com/KryptIT/luraph-v15-v14.x-deobfuscator.git\n"
        "  2) 然后在 config.json 里填 \"deobf_dir\": \"...\\\\luraph-v15-v14.x-deobfuscator\\\\Deobfuscator\\\\deobf\"\n"
        "     或者设置环境变量 DEOBF_DIR"
    )


def check_environment(deobf_dir: Path, python: str | None = None) -> dict:
    """检查解混淆器能不能跑：Luau 运行时、bin 目录、Python 版本。"""
    python = python or sys.executable
    exe = "luau.exe" if os.name == "nt" else "luau"
    luau = deobf_dir / "bin" / exe
    ast = deobf_dir / "bin" / ("luau-ast.exe" if os.name == "nt" else "luau-ast")
    return {
        "deobf_dir": str(deobf_dir),
        "python": python,
        "python_version": sys.version.split()[0],
        "luau": str(luau) if luau.is_file() else None,
        "luau_ast": str(ast) if ast.is_file() else None,
        "ok": _looks_like_deobf_dir(deobf_dir) and luau.is_file(),
    }


# --------------------------------------------------------------------------
# 小工具
# --------------------------------------------------------------------------

def read_head(path: Path, limit: int = 8192) -> str:
    """按 latin-1 读文件头（luraph 样本里常有任意字节，latin-1 不会抛错）。"""
    try:
        with path.open("rb") as fh:
            return fh.read(limit).decode("latin-1", errors="replace")
    except OSError:
        return ""


def sniff_banner(text: str) -> str | None:
    """从头部横幅里读出 Luraph 版本号，例如 '14.7' / '15'。"""
    m = BANNER_RE.search(text[:8192])
    return m.group(1) if m else None


def looks_like_v14(text: str) -> bool:
    """没有横幅时，靠形状猜这是不是 Luraph v14.x（cli.py 用的是同一套特征）。"""
    head = text.lstrip()[:20000]
    return head.startswith("return({") or head.startswith("local init = (function(") \
        or "return({" in head[:2000]


def apply_watermark(path: Path) -> bool:
    """把结果文件开头的解混淆器署名换成 WATERMARK，并保证水印在顶上。

    只动文件最开始的注释块（署名行、"dsc.gg/..."、"[best effort] ..." 之前的
    那些），脚本正文一行不碰。幂等：反复调用不会叠加多个水印。
    """
    try:
        raw = path.read_bytes()
    except OSError:
        return False
    try:
        text = raw.decode("utf-8")
        enc = "utf-8"
    except UnicodeDecodeError:
        text = raw.decode("latin-1")          # 保护脚本可能是任意字节
        enc = "latin-1"

    text = text.replace("\r\n", "\n").replace("\r", "\n")
    lines = text.split("\n")

    # 开头的注释块（最多看 200 行，避免把正文当成注释块）
    cut = 0
    while cut < len(lines) and cut < 200:
        ln = lines[cut]
        if ln.strip() and not ln.lstrip().startswith("--"):
            break
        cut += 1
    head, body = lines[:cut], lines[cut:]

    head = [ln for ln in head if not any(p.match(ln) for p in _CREDIT_PATTERNS)]
    while head and not head[0].strip():
        head.pop(0)
    while head and not head[-1].strip():
        head.pop()

    out_lines = ["-- " + WATERMARK, ""] + head + ([""] if head else []) + body
    out = "\n".join(out_lines)
    while out.endswith("\n\n"):
        out = out[:-1]
    if not out.endswith("\n"):
        out += "\n"

    if out == text:
        return False
    try:
        path.write_bytes(out.encode(enc, errors="replace"))
    except OSError:
        return False
    return True


def looks_like_trace(path: Path) -> bool:
    """输出是不是"只有行为追踪"（读文件头找标记）。"""
    head = read_head(path, 4096)
    return any(marker in head for marker in TRACE_MARKERS)


def _child_env() -> dict:
    env = os.environ.copy()
    # 让子进程始终用 UTF-8 输出，避免 Windows 上 cp936/cp1252 直接崩掉
    env["PYTHONUTF8"] = "1"
    env["PYTHONIOENCODING"] = "utf-8"
    env["PYTHONUNBUFFERED"] = "1"
    env.setdefault("PYTHONDONTWRITEBYTECODE", "1")
    return env


def _popen_kwargs() -> dict:
    if os.name == "nt":
        return {"creationflags": 0x08000000}       # CREATE_NO_WINDOW，不弹黑框
    return {"start_new_session": True}             # 方便整组 kill


async def kill_process_tree(proc: asyncio.subprocess.Process) -> None:
    """结束子进程（以及它拉起的 luau 子进程）。"""
    if proc.returncode is not None:
        return
    try:
        if os.name == "nt":
            subprocess.run(["taskkill", "/F", "/T", "/PID", str(proc.pid)],
                           capture_output=True)
        else:
            import signal
            os.killpg(os.getpgid(proc.pid), signal.SIGTERM)
    except Exception:
        try:
            proc.terminate()
        except ProcessLookupError:
            return
    try:
        await asyncio.wait_for(proc.wait(), timeout=6)
    except asyncio.TimeoutError:
        try:
            if os.name == "nt":
                subprocess.run(["taskkill", "/F", "/T", "/PID", str(proc.pid)],
                               capture_output=True)
            else:
                import signal
                os.killpg(os.getpgid(proc.pid), signal.SIGKILL)
        except Exception:
            pass


# --------------------------------------------------------------------------
# 命令行拼装
# --------------------------------------------------------------------------

def build_cmd(python: str, deobf_dir: Path, kind: str, src: Path, out: Path,
              opt: Options) -> list[str]:
    """按引擎类型拼出命令行。kind: 'v14' | 'v15' | 'generic'。"""
    base = [python, "-X", "utf8"]
    if kind == "v14":
        cmd = base + [str(deobf_dir / "cli.py"), str(src), "-o", str(out),
                      "--engine", opt.version,
                      "--timeout", str(opt.harness_timeout),
                      "--budget", str(opt.budget),
                      "--devirt-rounds", str(opt.rounds),
                      "--max-runs", str(opt.max_runs)]
        if opt.trace_only:
            cmd.append("--no-devirt")
        if opt.strings:
            cmd.append("--strings")
        if opt.debug:
            cmd.append("--debug")
        # 保留捕获文件（*.protos.json）：深度清单直接用它，不用再跑一遍
        cmd.append("--keep-work")
        return cmd

    if kind == "v15":
        cmd = base + [str(deobf_dir / "deob.py"), str(src), "-o", str(out),
                      "--obfuscator", "luraph_v15",
                      "--timeout", str(opt.harness_timeout),
                      "--budget", str(opt.budget),
                      "--devirt-rounds", str(opt.rounds),
                      "--max-runs", str(opt.max_runs)]
        if opt.trace_only:
            cmd.append("--no-devirt")
        if opt.strings:
            cmd.append("--strings")
        if opt.debug:
            cmd.append("--debug")
        return cmd

    if kind == "other":
        # 检测到别的混淆器（例如 ironbrew1）：让 deob.py 自己跑它的插件
        cmd = base + [str(deobf_dir / "deob.py"), str(src), "-o", str(out),
                      "--timeout", str(opt.harness_timeout),
                      "--budget", str(opt.budget)]
        if opt.trace_only:
            cmd.append("--no-devirt")
        if opt.strings:
            cmd.append("--strings")
        if opt.debug:
            cmd.append("--debug")
        return cmd

    # generic：认不出来的脚本，只能给行为追踪
    cmd = base + [str(deobf_dir / "deob.py"), str(src), "-o", str(out),
                  "--timeout", str(opt.harness_timeout),
                  "--budget", str(opt.budget),
                  "--no-devirt"]
    if opt.strings:
        cmd.append("--strings")
    if opt.debug:
        cmd.append("--debug")
    return cmd


async def _run_once(cmd: Sequence[str], cwd: Path, log_path: Path,
                    on_line: Callable[[str], None] | None,
                    hard_timeout: float,
                    cancel_event: asyncio.Event | None,
                    extra_env: dict | None = None) -> tuple[int | None, bool, bool]:
    """跑一条命令，边跑边把输出行喂给 on_line。

    返回 (returncode, timed_out, cancelled)。
    """
    env = _child_env()
    if extra_env:
        env.update(extra_env)
    proc = await asyncio.create_subprocess_exec(
        *cmd, cwd=str(cwd), env=env,
        stdout=asyncio.subprocess.PIPE, stderr=asyncio.subprocess.STDOUT,
        **_popen_kwargs(),
    )

    log_path.parent.mkdir(parents=True, exist_ok=True)
    log_fh = log_path.open("a", encoding="utf-8", errors="replace", newline="")
    log_fh.write("$ " + " ".join(str(c) for c in cmd) + "\n")
    log_fh.flush()

    async def pump() -> None:
        assert proc.stdout is not None
        while True:
            raw = await proc.stdout.readline()
            if not raw:
                break
            line = raw.decode("utf-8", errors="replace").rstrip("\r\n")
            log_fh.write(line + "\n")
            log_fh.flush()
            if on_line and line:
                try:
                    on_line(line)
                except Exception:
                    pass

    pump_task = asyncio.create_task(pump())
    wait_task = asyncio.create_task(proc.wait())
    cancel_task = asyncio.create_task(cancel_event.wait()) if cancel_event else None

    watch = {wait_task}
    if cancel_task:
        watch.add(cancel_task)

    timed_out = cancelled = False
    try:
        done, _ = await asyncio.wait(watch, timeout=hard_timeout,
                                     return_when=asyncio.FIRST_COMPLETED)
        if wait_task not in done:
            timed_out = cancel_task is None or cancel_task not in done
            cancelled = not timed_out
            await kill_process_tree(proc)
            try:
                await asyncio.wait_for(wait_task, timeout=10)
            except asyncio.TimeoutError:
                pass
    finally:
        if cancel_task and not cancel_task.done():
            cancel_task.cancel()
        try:
            await asyncio.wait_for(pump_task, timeout=10)
        except (asyncio.TimeoutError, Exception):
            pump_task.cancel()
        log_fh.close()

    return proc.returncode, timed_out, cancelled


# --------------------------------------------------------------------------
# 主流程
# --------------------------------------------------------------------------

async def detect_plugin(python: str, deobf_dir: Path, src: Path,
                        timeout: float = 120) -> tuple[str, str]:
    """调用 deob.py --detect，返回 (插件名, 置信度字符串)。"""
    cmd = [python, "-X", "utf8", str(deobf_dir / "deob.py"), str(src), "--detect"]
    proc = await asyncio.create_subprocess_exec(
        *cmd, cwd=str(deobf_dir), env=_child_env(),
        stdout=asyncio.subprocess.PIPE, stderr=asyncio.subprocess.DEVNULL,
        **_popen_kwargs(),
    )
    try:
        out, _ = await asyncio.wait_for(proc.communicate(), timeout=timeout)
    except asyncio.TimeoutError:
        await kill_process_tree(proc)
        return "", ""
    text = out.decode("utf-8", errors="replace").strip()
    parts = text.split("\t")
    if len(parts) >= 2:
        return parts[0].strip(), parts[1].strip()
    return text, ""


def _collect(lines: list[str]) -> tuple[list[str], list[str]]:
    """从日志里挑出警告和关键阶段行。"""
    warnings, stages = [], []
    for line in lines:
        s = line.strip()
        if s.startswith("[!]"):
            msg = s[3:].strip()
            if msg and msg not in warnings:
                warnings.append(msg)
        elif s.startswith("[*]") and any(
            key in s for key in ("devirt", "tracing", "constants", "run status",
                                 "engine", "obfuscator", "static", "fallback")
        ):
            stages.append(s[3:].strip())
    return warnings, stages


async def run_job(*, deobf_dir: Path, src: Path, workdir: Path, opt: Options,
                  python: str | None = None, hard_timeout: float = 900.0,
                  on_line: Callable[[str], None] | None = None,
                  cancel_event: asyncio.Event | None = None) -> Result:
    """执行一次完整的解混淆任务。所有文件都写在 workdir 里。"""
    python = python or sys.executable
    res = Result()
    started = time.monotonic()

    outdir = workdir / "out"
    outdir.mkdir(parents=True, exist_ok=True)
    out_path = outdir / (src.stem + ".deob.lua")
    log_path = workdir / "log.txt"

    versions: list[str] = []
    used_version = ""            # 真正产出结果的那个引擎版本（深度捕获要用）

    def note_version(v: str) -> None:
        if v not in versions:
            versions.append(v)

    # 1) 决定要尝试哪些引擎 -------------------------------------------------
    try:
        version = opt.normalized_version()
    except ValueError as exc:
        res.note = str(exc)
        res.elapsed = time.monotonic() - started
        return res

    head = read_head(src, 4096)
    banner = sniff_banner(head)
    attempts: list[Attempt] = []
    notes: list[str] = []

    if version in V14_VERSIONS:
        attempts = [Attempt("v14", version, f"Luraph v{version}")]
    elif version == "15":
        attempts = [Attempt("v15", "15", "Luraph v15")]
    elif version != "auto":                       # 兜底，正常走不到
        attempts = [Attempt("generic", "", "通用（仅行为追踪）", trace=True)]
    else:
        # ---- 自动检测 ----
        if banner in V14_VERSIONS:
            attempts = [Attempt("v14", banner, f"Luraph v{banner}")]
            notes.append(f"文件头横幅：v{banner}")
        elif banner and banner.split(".")[0] == "15":
            attempts = [Attempt("v15", "15", "Luraph v15")]
            notes.append("文件头横幅：v15")
        else:
            plugin, conf = await detect_plugin(python, deobf_dir, src)
            if plugin.startswith("luraph_v15"):
                attempts = [Attempt("v15", "15", "Luraph v15")]
                notes.append(f"deob.py 检测：{plugin}"
                             + (f"（置信度 {conf}）" if conf else ""))
            elif plugin.startswith("ironbrew"):
                attempts = [Attempt("other", "", f"{plugin}（实验性）")]
                notes.append(f"deob.py 检测：{plugin}"
                             + (f"（置信度 {conf}）" if conf else ""))
            elif looks_like_v14(head):
                order = ["14.7", "14.9", "14.8"]
                attempts = [Attempt("v14", v, f"Luraph v{v}") for v in order]
                notes.append("没有版本横幅，按 v14 依次尝试 " + " → ".join("v" + v for v in order))
            else:
                attempts = [Attempt("generic", "", "通用（仅行为追踪）", trace=True)]
                notes.append("认不出的混淆器，只能做行为追踪")

    # 用户显式要求 trace 时，所有尝试都只出行为追踪
    if opt.trace_only:
        for a in attempts:
            a.trace = True

    res.engine = attempts[0].label
    res.stages = list(notes)

    # 2) 依次尝试，谁先出结果用谁 -------------------------------------------
    all_lines: list[str] = []
    deadline = time.monotonic() + hard_timeout

    def on_line_wrap(line: str) -> None:
        all_lines.append(line)
        if on_line:
            on_line(line)

    log_path.write_text("", encoding="utf-8")

    for idx, attempt in enumerate(attempts):
        left = max(20.0, deadline - time.monotonic())
        if time.monotonic() >= deadline:
            res.timed_out = True
            res.note = f"超过硬超时（{int(hard_timeout)} 秒），已强制结束"
            break

        if len(attempts) > 1:
            res.stages.append(f"尝试 {idx + 1}/{len(attempts)}：{attempt.label}")
        use = Options(**{**opt.__dict__, "version": attempt.version or "auto",
                         "trace_only": attempt.trace})
        cmd = build_cmd(python, deobf_dir, attempt.kind, src, out_path, use)
        res.command = cmd
        # v14：默认直接上「完整配方」（KEEP_ALL/PARTIAL/LOOP_ONCE）。它才是把
        # 14.7 整份脚本走完的那条路（默认参数只出十几行行为追踪）；代价是慢。
        extra_env = dict(DEEP_ENV) if (attempt.kind == "v14" and opt.complete_v14) else None
        if extra_env:
            res.stages.append("v14 完整配方已启用（最完整，耗时较长）")
        rc, timed_out, cancelled = await _run_once(
            cmd, deobf_dir, log_path, on_line_wrap, left, cancel_event, extra_env=extra_env)

        res.returncode = rc
        if cancelled:
            res.cancelled = True
            break
        if out_path.is_file():
            res.engine = attempt.label
            used_version = use.version
            break

        # v14 静态反虚拟化失败时，用 --trace-fallback 再试一次（追踪也比什么都没有强）
        if attempt.kind == "v14" and not timed_out:
            left = max(20.0, deadline - time.monotonic())
            res.stages.append(f"{attempt.label} 没出源码，用 --trace-fallback 重试")
            cmd2 = cmd + ["--trace-fallback"]
            for i, tok in enumerate(cmd2):
                if tok == "--timeout":
                    cmd2[i + 1] = str(max(30, int(opt.harness_timeout) // 2))
            res.command = cmd2
            rc2, to2, cc2 = await _run_once(
                cmd2, deobf_dir, log_path, on_line_wrap, left, cancel_event,
                extra_env=extra_env)
            res.returncode = rc2
            if cc2:
                res.cancelled = True
                break
            if out_path.is_file():
                res.engine = attempt.label
                used_version = use.version
                res.fallback_used = True
                break
            timed_out = to2

        if timed_out:
            res.timed_out = True
            res.note = f"超过硬超时（{int(hard_timeout)} 秒），已强制结束"
            break

    # 3) 汇总 --------------------------------------------------------------
    res.elapsed = time.monotonic() - started
    res.output = out_path if out_path.is_file() else None
    res.log = "\n".join(all_lines[-400:])
    warnings, stages = _collect(all_lines)
    res.warnings = warnings
    res.stages = res.stages + stages

    final_engine = res.engine or (attempts[-1].label if attempts else "")
    res.engine = final_engine

    # 版本标注：有横幅就按横幅；没有横幅的 v14 样本再看运行日志里的"进入布局"证据。
    # （v14.7/14.8 是宿主直接调用 payload，#v14.9 是 VM 调度循环去调；实测三个引擎
    #   对无横幅样本产出一致，所以这里只影响展示，不影响解出来的结果。）
    if (res.engine or "").startswith("Luraph v14") and not any(
            n.startswith("文件头横幅") for n in notes):
        if V14_DISPATCH_LAYOUT.search("\n".join(all_lines)):
            res.engine = "Luraph v14.9"
            res.stages.append("无版本横幅：按运行时的 VM 调度布局判定为 v14.9")
        else:
            res.engine = "Luraph v14.x"
            res.stages.append("无版本横幅：v14.7/v14.8/v14.9 引擎对该样本产出一致")

    if res.cancelled:
        res.note = "任务被取消"
        return res
    if res.timed_out:
        return res
    if not res.output:
        res.note = res.note or "没有产出结果文件，日志见附件。"
        return res

    res.ok = True
    apply_watermark(res.output)          # 去掉解混淆器署名，换成我们的水印
    trace_hints = ("refusing v14 static output", "trace-assisted", "behaviour trace",
                   "behavior trace", "compact trace", "no-devirt")
    warned_trace = any(h in w.lower() for w in res.warnings for h in trace_hints)
    # 输出本身才算判据：日志里出现"回退到轨迹"的警告并不代表结果就是轨迹——
    # 14.8 这类样本会在严格模式被拒后改跑部分反虚拟化，产出的是两千多行真实代码。
    small_output = res.line_count <= 60 or res.size_bytes <= 8192
    if opt.trace_only or looks_like_trace(res.output) or (warned_trace and small_output):
        res.mode = "trace"
    else:
        res.mode = "devirt"

    if res.mode == "trace" and not opt.trace_only:
        res.note = ("这次只拿到行为追踪（脚本真正执行到的分支），不是完整的反虚拟化——"
                    "原脚本里没跑到的代码不会出现。")
        if (res.engine or "").startswith("Luraph v14"):
            res.note += ("想要更完整的静态结果，可在服务器设置环境变量 "
                         "DEVIRT_V14_KEEP_ALL=1 DEVIRT_V14_PARTIAL=1 "
                         "DEVIRT_V14_LOOP_ONCE=1 后重跑同一个文件。")
    if res.fallback_used:
        res.note = ((res.note + " ") if res.note else "") + "静态反虚拟化失败，已自动回退到行为追踪。"

    # ---- 深度补充：v14 样本再给「逐条反汇编 + 参考清单」 --------------------
    # 这两份清单是本次调研里最实在的改进：14.9 那种结果几乎是加密块的样本，
    # 反汇编清单（631 条指令）和 460 条字符串常量比结果本身有用得多。
    no_deep = str(os.environ.get("DEOBF_NO_DEEP_CAPTURE", "")).strip().lower() in (
        "1", "true", "yes", "on")
    if no_deep:
        res.stages.append("深度捕获：已按 DEOBF_NO_DEEP_CAPTURE 关闭")
    if (res.engine or "").startswith("Luraph v14") and used_version and not no_deep:
        left = deadline - time.monotonic()
        if left > 30:
            m_ver = re.search(r"v(\d+\.\d+)", res.engine or "")
            found_ver = m_ver.group(1) if m_ver else used_version
            try:
                deep = await deep_capture(
                    python=python, deobf_dir=deobf_dir, src=src, workdir=workdir,
                    opt=opt, base_out=out_path, version=found_ver,
                    timeout=min(left - 10, 480.0), on_line=on_line_wrap)
            except Exception as exc:                      # 绝不因为附加品失败影响主结果
                deep = {"note": f"深度捕获异常：{exc}"}
            got: list[str] = []
            if deep.get("lift"):                          # 真代码排最前面
                res.extras.append(deep["lift"])
                ok = deep.get("lift_ok")
                got.append("部分反编译" + ("（语法检查通过）" if ok else ""))
            if deep.get("refs"):
                res.extras.append(deep["refs"])
                got.append("参考清单")
            if deep.get("disasm"):
                res.extras.append(deep["disasm"])
                got.append("逐条反汇编")
            stats = deep.get("stats") or {}
            if got:
                res.stages.append(
                    "深度捕获：%s（%s 条字符串 / %s 个 API 引用 / %s 个 proto / %s 段字节码）"
                    % ("、".join(got), len(stats.get("strings") or []),
                       len(stats.get("funcs") or []), stats.get("protos") or 0,
                       stats.get("bytecode_arrays") or 0))
                res.note = ((res.note + " ") if res.note else "") + (
                    "另外附了「%s」——反虚拟化没走到的地方，可以拿这些对照着看。"
                    % "」「".join(got))
            elif deep.get("note"):
                res.stages.append("深度捕获：" + str(deep["note"]))

    # ---- 折叠前的完整版（含全部 VM 数据表）：跟着结果一起发 --------------
    full_lift = out_path.with_name(out_path.name + ".full.lua")
    if full_lift.is_file():
        res.extras.append(full_lift)
        try:
            mb = full_lift.stat().st_size / 1048576
            res.stages.append("完整版（未折叠数据表）：%.1f MB" % mb)
        except OSError:
            pass

    return res


# --------------------------------------------------------------------------
# v14 深度捕获：lifter 走不通时，至少给出「逐条反汇编 + 常量/API 清单」
#
# 上游 devirt.py 自带一个调试 CLI：
#   python obfuscators/luraph_v14_8/devirt.py <src> <protos.json> --raw <root>
# 它能把捕获到的 proto 逐条打印出来（寄存器级操作 + 跳转 + 断点原因）。14.9 这种
# 反虚拟化基本失败、结果几乎是加密块的样本，这份清单比结果本身有用得多。
# --------------------------------------------------------------------------

#: 让 14.7 / 14.9 也尽力做出静态捕获（不给这三个变量时它们只出行为追踪）
DEEP_ENV = {
    "DEVIRT_V14_KEEP_ALL": "1",
    "DEVIRT_V14_PARTIAL": "1",
    "DEVIRT_V14_LOOP_ONCE": "1",
}


def find_protos_json(workdir: Path) -> Path | None:
    """找捕获阶段的 *.protos.json（上游在 --keep-work 时写在 .<名字>_work/ 里）。"""
    try:
        hits = sorted(workdir.rglob("*.protos.json"))
    except OSError:
        return None
    return hits[0] if hits else None


def summarize_protos(protos_json: Path) -> dict:
    """从 protos.json 抽出字符串常量、API/函数引用、结构和字节码规模统计。

    数据来自我们自己的运行时捕获：常量在表里是 {"s": 十六进制} 或 {"f": "bit32.lshift"}。
    """
    import json as _json

    info = {"strings": [], "funcs": [], "protos": 0, "tables": 0,
            "bytecode_arrays": 0, "bytecode_ints": 0, "root": None}
    try:
        data = _json.loads(protos_json.read_text(encoding="utf-8", errors="replace"))
    except (OSError, ValueError):
        return info
    if not isinstance(data, dict):
        return info

    protos = data.get("protos") or {}
    tables = data.get("tables") or {}
    info["protos"] = len(protos) if hasattr(protos, "__len__") else 0
    info["tables"] = len(tables) if hasattr(tables, "__len__") else 0
    cands = data.get("root_candidates") or []
    info["root"] = cands[0] if cands else data.get("root_callee")
    info["root_candidates"] = list(cands)

    strings: set[str] = set()
    funcs: set[str] = set()

    def take(item) -> None:
        if not isinstance(item, dict):
            return
        if isinstance(item.get("s"), str):
            try:
                text = bytes.fromhex(item["s"]).decode("utf-8", "replace")
            except ValueError:
                return
            if text and len(text) <= 4000:
                strings.add(text)
        elif isinstance(item.get("f"), str):
            funcs.add(item["f"])

    for tab in (tables.values() if hasattr(tables, "values") else []):
        if not isinstance(tab, dict):
            continue
        arr = tab.get("arr")
        if isinstance(arr, list):
            if arr and all(isinstance(x, int) for x in arr) and len(arr) > 16:
                info["bytecode_arrays"] += 1
                info["bytecode_ints"] += len(arr)
            else:
                for item in arr:
                    take(item)
        for pair in (tab.get("kv") or []):
            if isinstance(pair, (list, tuple)) and len(pair) == 2:
                take(pair[0])
                take(pair[1])

    # 实测：真正干活的 proto 编号都很小（14.7 root 1 → 877 行，14.8 root 2 →
    # 1036 行，而 root_callee 猜到的 35 只有 423 行），所以候选按编号从小到大补。
    nums = sorted(int(k) for k in protos if str(k).isdigit()) if hasattr(protos, "__iter__") else []
    info["low_protos"] = nums[:8]

    info["strings"] = sorted(strings)
    info["funcs"] = sorted(funcs)
    return info


def write_reference_list(protos_json: Path, out: Path, *, source_name: str = "") -> dict:
    """把 summarize_protos 的结果写成一份人能看的清单。"""
    info = summarize_protos(protos_json)
    lines: list[str] = ["-- 参考清单（来自运行时捕获，不是猜测）"]
    if source_name:
        lines.append("-- 样本：" + source_name)
    lines.append(f"-- proto {info['protos']} 个 / 数据表 {info['tables']} 个 / "
                 f"疑似字节码数组 {info['bytecode_arrays']} 段（{info['bytecode_ints']} 个整数）")
    lines.append("")
    lines.append(f"== API / 函数引用（{len(info['funcs'])} 个，去重）==")
    lines.extend("  " + f for f in info["funcs"]) or lines.append("  （没有捕获到）")
    if not info["funcs"]:
        lines.append("  （没有捕获到）")
    lines.append("")
    lines.append(f"== 字符串常量（{len(info['strings'])} 条，去重）==")
    for text in info["strings"]:
        one = text.replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t")
        if len(one) > 400:
            one = one[:400] + "…（共 %d 字符）" % len(text)
        lines.append("  " + one)
    if not info["strings"]:
        lines.append("  （没有捕获到）")
    lines.append("")
    try:
        out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    except OSError:
        pass
    return info


def _devirt_script(deobf_dir: Path, version: str) -> Path | None:
    """debf 的引擎脚本：obfuscators/luraph_v14_7/devirt.py 之类。"""
    slug = "luraph_v" + str(version).strip().lstrip("vV").replace(".", "_")
    for base in (deobf_dir, deobf_dir.parent, deobf_dir.parent.parent):
        cand = base / "obfuscators" / slug / "devirt.py"
        if cand.is_file():
            return cand
    return None


def _version_from_workdir(protos_json: Path) -> str | None:
    """从 .input.luraph_v14_7_work/ 这类目录名反推引擎版本（比猜测准）。"""
    import re as _re
    m = _re.search(r"luraph_v(\d+)_(\d+)", str(protos_json.parent.name))
    return f"{m.group(1)}.{m.group(2)}" if m else None


async def deep_capture(*, python: str, deobf_dir: Path, src: Path, workdir: Path,
                       opt: Options, base_out: Path, version: str,
                       timeout: float = 480.0,
                       on_line: Callable[[str], None] | None = None) -> dict:
    """v14 专用第二遍：完整配方跑一次静态捕获，再产出反汇编与参考清单。

    返回 {"ran", "disasm", "refs", "stats", "note"}；任何一步失败只是少一个附件。
    """
    out_dir = base_out.parent
    result: dict = {"ran": False, "disasm": None, "refs": None, "stats": {}, "note": ""}
    display_ver = str(version).strip().lstrip("vV") or "14.x"
    script = _devirt_script(deobf_dir, version)

    if not find_protos_json(workdir):          # 主流程没留下捕获 -> 自己跑一遍
        deep_dir = workdir / "deep"
        deep_out = deep_dir / "out" / base_out.name
        deep_dir.mkdir(parents=True, exist_ok=True)
        if script is None:
            result["note"] = "该版本没有 devirt.py，跳过深度捕获"
            return result
        use = Options(**{**opt.__dict__, "version": version, "trace_only": False})
        cmd = build_cmd(python, deobf_dir, "v14", src, deep_out, use) + ["--keep-work"]
        env = _child_env()
        env.update(DEEP_ENV)
        result["ran"] = True
        proc = None
        try:
            proc = await asyncio.create_subprocess_exec(
                *cmd, cwd=str(deobf_dir), env=env,
                stdout=asyncio.subprocess.PIPE, stderr=asyncio.subprocess.STDOUT,
                **_popen_kwargs())

            async def _drain() -> None:
                assert proc is not None and proc.stdout is not None
                async for raw in proc.stdout:
                    if on_line:
                        on_line(raw.decode("utf-8", "replace"))
            await asyncio.wait_for(asyncio.gather(_drain(), proc.wait()), timeout)
        except asyncio.TimeoutError:
            result["note"] = "深度捕获超时，未产出额外清单"
            if proc is not None:
                await kill_process_tree(proc)
            return result
        except (OSError, asyncio.CancelledError) as exc:
            if proc is not None:
                await kill_process_tree(proc)
            if isinstance(exc, asyncio.CancelledError):
                raise
            result["note"] = "深度捕获启动失败：%s" % exc
            return result

    protos = find_protos_json(workdir)
    if protos is None:
        result["note"] = result["note"] or "深度捕获没有产生 protos.json（该样本可能只支持行为追踪）"
        return result

    # 捕获是哪个版本的引擎做出来的，就用哪个版本的 devirt 去读
    v2 = _version_from_workdir(protos)
    if v2:
        script = _devirt_script(deobf_dir, v2) or script
    if script is None:
        result["note"] = "没找到本版本的 devirt.py，跳过了反汇编清单"
        return result

    refs = out_dir / (base_out.stem + ".参考清单.txt")
    result["stats"] = write_reference_list(protos, refs, source_name=src.name)
    if refs.is_file():
        result["refs"] = refs


    # ---- 反汇编：把候选根都试一遍，取最长的那份（挑错根只剩几百行脚手架）----
    # 顺序很讲究：实测编号最小的 proto（1、2）才是真正干活的根，而上游给的
    # root_callee 经常是脚手架，所以「头两个候选 + 小号 proto」都要试到。
    st = result["stats"]
    hinted = [c for c in ([st.get("root")] + list(st.get("root_candidates") or []))
              if c is not None]
    order = hinted[:3] + list(st.get("low_protos") or []) + hinted[3:]
    tries: list[object] = []
    for cand in order:
        if cand not in tries:
            tries.append(cand)
    tries = tries[:8]

    best_text, best_root, spent = "", None, 0.0
    for root in tries[:6]:
        budget = min(timeout, 300.0) - spent
        if budget < 5:
            break
        started = time.monotonic()
        text = await _devirt_raw(python, script, deobf_dir, src, protos, root, budget)
        spent += time.monotonic() - started
        if len(text) > len(best_text):
            best_text, best_root = text, root
        if len(best_text.splitlines()) >= 4000:      # 已经足够全，不必再试
            break
    if best_text.strip():
        disasm = out_dir / (base_out.stem + ".反汇编.txt")
        header = ("-- 逐条反汇编（寄存器级）：来自深度捕获，lifter 走不通的位置会标 !!\n"
                  f"-- 引擎 Luraph v{display_ver}；"
                  f"root proto #{best_root}（共试了 {len(tries)} 个根，取最完整的一份）\n"
                  "-- 说明：这是「每条 VM 指令做了什么」，不是完整源码；\n"
                  "--       但它能看到结果文件里被跳过/加密的部分，请配合参考清单一起看。\n\n")
        try:
            disasm.write_text(header + best_text, encoding="utf-8")
            result["disasm"] = disasm
            result["root_used"] = best_root
        except OSError:
            pass

    # ---- 部分反编译：逐块 --lift，把没进主结果的真代码也捞出来 ----
    # 实测：14.9 主结果只有 39 行追踪，但 --lift 2 能给出 337 行真 Luau（语法通过）；
    # 14.8 的 --lift 1/2 各有 2100/2000 行，和主结果重合不到 2%。
    try:
        main_text = base_out.read_text(encoding="utf-8", errors="replace")
    except OSError:
        main_text = ""
    luau_ast = deobf_dir / "bin" / ("luau-ast.exe" if os.name == "nt" else "luau-ast")
    sections: list[tuple[object, str]] = []
    for root in tries[:5]:
        budget = min(timeout, 300.0) - spent
        if budget < 8:
            break
        started = time.monotonic()
        rc, text = await _devirt_run(python, script, deobf_dir, src, protos,
                                     ["--lift", str(root), "--allow-partial"], budget)
        spent += time.monotonic() - started
        if rc == 0 and text.strip() and _novel_ratio(text, main_text) >= 0.6:
            sections.append((root, text))

    if sections:
        # 每段单独做语法检查（拼接在一起会因为重名的 local 互相干扰，看不出真实情况）
        checked = [(root, text, _syntax_ok(luau_ast, text, out_dir)) for root, text in sections]
        n_ok = sum(1 for _, _, ok in checked if ok)
        mark = {True: "语法检查：通过", False: "语法检查：未通过（残片，仅作参考）",
                None: "语法检查：跳过（本机没有 luau-ast）"}
        body = "".join(
            f"\n-- ============================================================\n"
            f"-- root proto #{root}　{mark[ok]}　（这一段可以单独阅读）\n"
            f"-- ============================================================\n{text}\n"
            for root, text, ok in checked)
        head = ("-- 部分反编译（来自深度捕获）：主结果里被跳过/加密、但这里能还原成真代码的部分\n"
                f"-- 引擎 Luraph v{display_ver}；共 {len(checked)} 段，"
                f"{n_ok} 段单独通过语法检查\n"
                "-- 说明：每段是一块独立代码，段与段之间可能不连贯（缺的那部分 VM 状态没解出来），\n"
                "--       但里面的逻辑都是真的；需要完整源码请以主结果为准。\n\n")
        lift_ok = (n_ok == len(checked)) or None if luau_ast is None else (n_ok == len(checked))
        lift = out_dir / (base_out.stem + ".部分反编译.lua")
        try:
            lift.write_text(head + body, encoding="utf-8")
            result["lift"] = lift
            result["lift_lines"] = sum(len(t.splitlines()) for _, t in sections)
            result["lift_ok"] = lift_ok
        except OSError:
            pass
    return result


async def _devirt_run(python: str, script: Path, deobf_dir: Path, src: Path,
                       protos: Path, args: list[str], budget: float) -> tuple[int, str]:
    """跑一次 devirt.py 的调试命令，返回 (返回码, 标准输出)。失败返回 (-1, "")。"""
    cmd = [python, "-X", "utf8", str(script), str(src), str(protos)] + args
    proc = None
    try:
        proc = await asyncio.create_subprocess_exec(
            *cmd, cwd=str(deobf_dir), env=_child_env(),
            stdout=asyncio.subprocess.PIPE, stderr=asyncio.subprocess.DEVNULL,
            **_popen_kwargs())
        out, _ = await asyncio.wait_for(proc.communicate(), timeout=budget)
        return proc.returncode or 0, out.decode("utf-8", "replace")
    except asyncio.TimeoutError:
        if proc is not None:
            await kill_process_tree(proc)
        return -1, ""
    except OSError:
        return -1, ""


async def _devirt_raw(python: str, script: Path, deobf_dir: Path, src: Path,
                      protos: Path, root: object, budget: float) -> str:
    rc, text = await _devirt_run(python, script, deobf_dir, src, protos,
                                 ["--raw", str(root)], budget)
    return text if rc == 0 else ""


def _syntax_ok(luau_ast: Path | None, text: str, tmp_dir: Path) -> bool | None:
    """用 luau-ast 检查语法；没有 luau-ast 时返回 None（表示没检查）。"""
    if luau_ast is None or not Path(luau_ast).is_file():
        return None
    import subprocess as _sp
    tmp = tmp_dir / "_syntax_check.luau"
    try:
        tmp.write_text(text, encoding="utf-8")
        proc = _sp.run([str(luau_ast), str(tmp)], capture_output=True, timeout=60)
        return proc.returncode == 0
    except (OSError, _sp.SubprocessError):
        return None
    finally:
        try:
            tmp.unlink()
        except OSError:
            pass


def _novel_ratio(candidate: str, existing: str) -> float:
    """candidate 里有多少行是 existing 里没有的（判断这份产物是否只是重复）。"""
    if not existing.strip():
        return 1.0
    lines = [l.strip() for l in candidate.splitlines() if len(l.strip()) > 20]
    if not lines:
        return 0.0
    sample = lines[:120]
    new = sum(1 for l in sample if l not in existing)
    return new / len(sample)


def prepare_input(raw: Path, workdir: Path, keep_name: str | None = None) -> Path:
    """把上传的附件规整成 workdir/input.<ext>，避免奇怪的文件名/扩展名。"""
    name = keep_name or raw.name
    ext = Path(name).suffix.lower()
    if ext not in (".lua", ".luau", ".txt", ".lph", ".luraph"):
        ext = ".lua"
    dest = workdir / ("input" + ext)
    workdir.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(raw, dest)
    return dest


# --------------------------------------------------------------------------
# 命令行自测入口（不依赖 Discord，用来确认环境能不能解混淆）
# --------------------------------------------------------------------------

def _main(argv: list[str] | None = None) -> int:
    import argparse

    ap = argparse.ArgumentParser(description="解混淆器封装层的命令行自测")
    ap.add_argument("input", help="被保护的 Lua/Luau 文件")
    ap.add_argument("--version", default="auto", help="auto / 14.7 / 14.8 / 14.9 / 15")
    ap.add_argument("--deobf-dir", default=None, help="解混淆器根目录")
    ap.add_argument("--trace", action="store_true", help="只要行为追踪")
    ap.add_argument("--strings", action="store_true")
    ap.add_argument("--debug", action="store_true")
    ap.add_argument("--timeout", type=int, default=150)
    ap.add_argument("--hard-timeout", type=float, default=900)
    ap.add_argument("-o", "--outdir", default=None, help="工作目录（默认 ./.selftest）")
    args = ap.parse_args(argv)

    try:
        deobf_dir = find_deobf_dir(args.deobf_dir)
    except DeobfNotFound as exc:
        print(f"[x] {exc}", file=sys.stderr)
        return 2

    env = check_environment(deobf_dir)
    print(f"[*] 解混淆器: {env['deobf_dir']}")
    print(f"[*] Python  : {env['python_version']}")
    print(f"[*] Luau    : {env['luau'] or '（缺失，Windows 上会自动下载 / Linux 需自备）'}")
    print(f"[*] luau-ast: {'有' if env['luau_ast'] else '（缺失，大脚本可能失败）'}")

    workdir = Path(args.outdir or "./.selftest").resolve()
    if workdir.exists():
        shutil.rmtree(workdir, ignore_errors=True)
    src = prepare_input(Path(args.input).resolve(), workdir)

    opt = Options(version=args.version, trace_only=args.trace, strings=args.strings,
                  debug=args.debug, harness_timeout=args.timeout)

    def echo(line: str) -> None:
        print("   | " + line, file=sys.stderr)

    res = asyncio.run(run_job(deobf_dir=deobf_dir, src=src, workdir=workdir, opt=opt,
                              hard_timeout=args.hard_timeout, on_line=echo))

    print("-" * 60)
    print(f"结果 : {'成功' if res.ok else '失败'}")
    print(f"引擎 : {res.engine}")
    print(f"模式 : {'行为追踪' if res.mode == 'trace' else '反虚拟化'} "
          f"{'(回退)' if res.fallback_used else ''}")
    print(f"用时 : {res.elapsed:.1f}s   返回码: {res.returncode}")
    if res.output:
        print(f"输出 : {res.output}  ({res.size_bytes / 1024:.1f} KB, {res.line_count} 行)")
    for w in res.warnings:
        print(f"警告 : {w}")
    if res.note:
        print(f"说明 : {res.note}")
    print(f"日志 : {workdir / 'log.txt'}")
    return 0 if res.ok else 1


if __name__ == "__main__":
    try:
        from winpause import fix_output_encoding, run_cli
        fix_output_encoding()
    except ImportError:
        raise SystemExit(_main())
    raise SystemExit(run_cli(_main))
