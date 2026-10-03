#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Thin process adapter for the upstream KryptIT deobfuscator.

This module does not patch, post-process, or replace the upstream engine output.
It only selects the upstream frontend, supervises its process, and records logs.
"""
from __future__ import annotations

import asyncio
import os
import re
import shutil
import subprocess
import sys
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Callable, Iterable, Sequence

BANNER_RE = re.compile(
    r"protected\s+using\s+Luraph\s+Obfuscator\s+v?(\d+(?:\.\d+)?)", re.I
)
V14_VERSIONS = ("14.7", "14.8", "14.9")
VERSION_ALIASES = {
    "auto": "auto", "": "auto", "detect": "auto", "自动": "auto",
    "14": "14.7", "14.7": "14.7", "v14.7": "14.7", "147": "14.7",
    "14.8": "14.8", "v14.8": "14.8", "148": "14.8",
    "14.9": "14.9", "v14.9": "14.9", "149": "14.9",
    "15": "15", "v15": "15", "15.0": "15",
}
_REQUIRED_FILES = ("harness.py", "deob.py", "cli.py")
_REQUIRED_DIRS = ("obfuscators",)
TRACE_HINTS = (
    "yeah this ran at runtime", "not gonna be full", "behavior trace",
    "behaviour trace", "trace-assisted", "compact trace", "refusing v14 static output",
)


class DeobfNotFound(RuntimeError):
    """The upstream deobfuscator directory could not be found."""


@dataclass
class Options:
    """Upstream CLI options exposed to the bot."""

    version: str = "auto"
    trace_only: bool = False
    strings: bool = False
    debug: bool = False
    harness_timeout: int = 150
    budget: int = 30
    rounds: int = 200
    max_runs: int = 12

    def normalized_version(self) -> str:
        key = (self.version or "auto").strip().lower()
        if key not in VERSION_ALIASES:
            raise ValueError(
                f"不支持的版本 {self.version!r}（可用：auto / 14.7 / 14.8 / 14.9 / 15）"
            )
        return VERSION_ALIASES[key]


@dataclass
class Result:
    """One upstream CLI invocation and its unmodified output file."""

    ok: bool = False
    output: Path | None = None
    engine: str = ""
    mode: str = "devirt"
    elapsed: float = 0.0
    returncode: int | None = None
    cancelled: bool = False
    timed_out: bool = False
    log: str = ""
    note: str = ""

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


def _looks_like_deobf_dir(path: Path) -> bool:
    return (
        path.is_dir()
        and all((path / name).is_file() for name in _REQUIRED_FILES)
        and all((path / name).is_dir() for name in _REQUIRED_DIRS)
    )


def find_deobf_dir(explicit: str | os.PathLike | None = None,
                   extra_candidates: Iterable[str | os.PathLike] = ()) -> Path:
    """Find the upstream `Deobfuscator/deobf` directory."""
    candidates: list[Path] = []

    def push(value: str | os.PathLike | None) -> None:
        if value:
            candidates.append(Path(value).expanduser())

    push(explicit)
    push(os.environ.get("DEOBF_DIR"))
    for value in extra_candidates:
        push(value)

    here = Path(__file__).resolve().parent
    for base in (here, here.parent, Path.cwd()):
        push(base / "vendor" / "luraph-deobf" / "Deobfuscator" / "deobf")
        push(base / "vendor" / "deobf")
        push(base / "deobf" / "Deobfuscator" / "deobf")
        push(base / "Deobfuscator" / "deobf")
        push(base / "deobf")
        push(base / "luraph-v15-v14.x-deobfuscator" / "Deobfuscator" / "deobf")
        vendor = base / "vendor"
        if vendor.is_dir():
            try:
                for child in sorted(vendor.iterdir()):
                    if child.is_dir():
                        push(child / "Deobfuscator" / "deobf")
                        push(child / "deobf")
            except OSError:
                pass

    seen: set[Path] = set()
    for candidate in candidates:
        try:
            resolved = candidate.resolve()
        except OSError:
            continue
        if resolved not in seen and _looks_like_deobf_dir(resolved):
            return resolved
        seen.add(resolved)

    raise DeobfNotFound(
        "找不到上游解混淆器目录（需要包含 deob.py / cli.py / obfuscators/）。\n"
        "请先运行 setup.bat / setup.ps1 / setup.sh，或设置 DEOBF_DIR。"
    )


def check_environment(deobf_dir: Path, python: str | None = None) -> dict:
    python = python or sys.executable
    exe = "luau.exe" if os.name == "nt" else "luau"
    ast_exe = "luau-ast.exe" if os.name == "nt" else "luau-ast"
    luau = deobf_dir / "bin" / exe
    ast = deobf_dir / "bin" / ast_exe
    return {
        "deobf_dir": str(deobf_dir),
        "python": python,
        "python_version": sys.version.split()[0],
        "luau": str(luau) if luau.is_file() else None,
        "luau_ast": str(ast) if ast.is_file() else None,
        "ok": _looks_like_deobf_dir(deobf_dir) and luau.is_file(),
    }


def read_head(path: Path, limit: int = 8192) -> str:
    try:
        with path.open("rb") as fh:
            return fh.read(limit).decode("latin-1", errors="replace")
    except OSError:
        return ""


def sniff_banner(text: str) -> str | None:
    match = BANNER_RE.search(text[:8192])
    return match.group(1) if match else None


def looks_like_v14(text: str) -> bool:
    """Choose the upstream v14 frontend; the upstream CLI still resolves version."""
    head = text.lstrip()[:20000]
    return (
        head.startswith("return({")
        or head.startswith("local init = (function(")
        or "return({" in head[:2000]
    )


def _child_env() -> dict[str, str]:
    env = os.environ.copy()
    env["PYTHONUTF8"] = "1"
    env["PYTHONIOENCODING"] = "utf-8"
    env["PYTHONUNBUFFERED"] = "1"
    env.setdefault("PYTHONDONTWRITEBYTECODE", "1")
    return env


def _popen_kwargs() -> dict:
    if os.name == "nt":
        return {"creationflags": 0x08000000}
    return {"start_new_session": True}


async def kill_process_tree(proc: asyncio.subprocess.Process) -> None:
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


def choose_frontend(source: str, requested_version: str) -> tuple[str, str, str]:
    """Select only which upstream frontend to call; no engine-selection retries."""
    version = requested_version
    if version == "auto":
        banner = sniff_banner(source)
        if banner in V14_VERSIONS:
            version = banner
        elif banner and banner.split(".", 1)[0] == "15":
            version = "15"
        elif looks_like_v14(source):
            version = "auto"
        else:
            return "auto", "auto", "上游自动识别"

    if version in V14_VERSIONS or (version == "auto" and looks_like_v14(source)):
        label = f"Luraph v{version}" if version in V14_VERSIONS else "Luraph v14.x（上游自动识别）"
        return "v14", version, label
    if version == "15":
        return "v15", "15", "Luraph v15"
    return "auto", "auto", "上游自动识别"


def build_cmd(python: str, deobf_dir: Path, kind: str, src: Path,
              out: Path, opt: Options, version: str = "auto") -> list[str]:
    """Build a command for the upstream CLI without custom engine arguments."""
    base = [python, "-X", "utf8"]
    if kind == "v14":
        cmd = base + [
            str(deobf_dir / "cli.py"), str(src), "-o", str(out),
            "--engine", version,
            "--timeout", str(opt.harness_timeout),
            "--budget", str(opt.budget),
            "--devirt-rounds", str(opt.rounds),
            "--max-runs", str(opt.max_runs),
        ]
        if opt.trace_only:
            cmd.append("--no-devirt")
        else:
            # Official upstream fallback: stay in one CLI invocation; when static
            # recovery yields nothing, let upstream write its behavior trace.
            cmd.append("--trace-fallback")
        if opt.strings:
            cmd.append("--strings")
        if opt.debug:
            cmd.append("--debug")
        return cmd

    cmd = base + [str(deobf_dir / "deob.py"), str(src), "-o", str(out)]
    if kind == "v15":
        cmd.extend(["--obfuscator", "luraph_v15"])
    cmd.extend([
        "--timeout", str(opt.harness_timeout),
        "--budget", str(opt.budget),
        "--devirt-rounds", str(opt.rounds),
        "--max-runs", str(opt.max_runs),
    ])
    if opt.trace_only:
        cmd.append("--no-devirt")
    if opt.strings:
        cmd.append("--strings")
    if opt.debug:
        cmd.append("--debug")
    return cmd


async def _run_once(cmd: Sequence[str], cwd: Path, log_path: Path,
                    on_line: Callable[[str], None] | None,
                    hard_timeout: float,
                    cancel_event: asyncio.Event | None
                    ) -> tuple[int | None, bool, bool, list[str]]:
    env = _child_env()
    proc = await asyncio.create_subprocess_exec(
        *cmd, cwd=str(cwd), env=env,
        stdout=asyncio.subprocess.PIPE, stderr=asyncio.subprocess.STDOUT,
        **_popen_kwargs(),
    )
    log_path.parent.mkdir(parents=True, exist_ok=True)
    lines: list[str] = []
    with log_path.open("a", encoding="utf-8", errors="replace", newline="") as log_fh:
        log_fh.write("$ " + " ".join(str(part) for part in cmd) + "\n")
        log_fh.flush()

        async def pump() -> None:
            assert proc.stdout is not None
            while True:
                raw = await proc.stdout.readline()
                if not raw:
                    break
                line = raw.decode("utf-8", errors="replace").rstrip("\r\n")
                lines.append(line)
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
            done, _ = await asyncio.wait(
                watch, timeout=hard_timeout, return_when=asyncio.FIRST_COMPLETED
            )
            if wait_task not in done:
                cancelled = bool(cancel_task and cancel_task in done)
                timed_out = not cancelled
                await kill_process_tree(proc)
                try:
                    await asyncio.wait_for(wait_task, timeout=10)
                except asyncio.TimeoutError:
                    pass
        except asyncio.CancelledError:
            # Bot shutdown can cancel the worker itself; never orphan the Luau child.
            await kill_process_tree(proc)
            try:
                await asyncio.wait_for(wait_task, timeout=10)
            except asyncio.TimeoutError:
                pass
            raise
        finally:
            if cancel_task and not cancel_task.done():
                cancel_task.cancel()
            try:
                await asyncio.wait_for(pump_task, timeout=10)
            except (asyncio.TimeoutError, Exception):
                pump_task.cancel()

    return proc.returncode, timed_out, cancelled, lines


async def run_job(*, deobf_dir: Path, src: Path, workdir: Path, opt: Options,
                  python: str | None = None, hard_timeout: float = 900.0,
                  on_line: Callable[[str], None] | None = None,
                  cancel_event: asyncio.Event | None = None) -> Result:
    """Run exactly one upstream frontend invocation and preserve its output."""
    started = time.monotonic()
    res = Result()
    try:
        requested = opt.normalized_version()
    except ValueError as exc:
        res.note = str(exc)
        return res

    python = python or sys.executable
    out_dir = workdir / "out"
    out_dir.mkdir(parents=True, exist_ok=True)
    out_path = out_dir / (src.stem + ".deob.lua")
    log_path = workdir / "log.txt"
    try:
        out_path.unlink(missing_ok=True)
        log_path.write_text("", encoding="utf-8")
    except OSError as exc:
        res.note = f"无法准备任务目录：{exc}"
        return res

    source = read_head(src, 20000)
    kind, engine_version, label = choose_frontend(source, requested)
    res.engine = label
    cmd = build_cmd(python, deobf_dir, kind, src, out_path, opt, engine_version)

    try:
        rc, timed_out, cancelled, lines = await _run_once(
            cmd, deobf_dir, log_path, on_line, hard_timeout, cancel_event
        )
    except OSError as exc:
        lines = []
        rc = None
        timed_out = cancelled = False
        res.note = f"无法启动上游 CLI：{exc}"

    res.returncode = rc
    res.timed_out = timed_out
    res.cancelled = cancelled
    res.elapsed = time.monotonic() - started
    res.log = "\n".join(lines[-400:])
    try:
        res.output = out_path if out_path.is_file() and out_path.stat().st_size > 0 else None
    except OSError:
        res.output = None

    if cancelled:
        res.note = "任务被取消。"
        return res
    if timed_out:
        res.note = f"超过硬超时（{int(hard_timeout)} 秒），已结束上游 CLI。"
        return res
    if res.output is None:
        res.note = res.note or "上游 CLI 没有产出 Lua 结果；请查看服务器任务日志。"
        return res

    res.ok = True
    log_text = "\n".join(lines).lower()
    output_head = read_head(res.output, 4096).lower()
    res.mode = "trace" if opt.trace_only or any(
        hint in log_text or hint in output_head for hint in TRACE_HINTS
    ) else "devirt"
    if res.mode == "trace" and not opt.trace_only:
        res.note = "上游引擎本次只恢复了行为追踪路径；脚本可能不完整。"
    return res


def prepare_input(raw: Path, workdir: Path, keep_name: str | None = None) -> Path:
    """Copy an uploaded file into a predictable task-local path."""
    name = keep_name or raw.name
    ext = Path(name).suffix.lower()
    if ext not in (".lua", ".luau", ".txt", ".lph", ".luraph"):
        ext = ".lua"
    dest = workdir / ("input" + ext)
    workdir.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(raw, dest)
    return dest


def _main(argv: list[str] | None = None) -> int:
    import argparse

    parser = argparse.ArgumentParser(description="上游解混淆 CLI 的直接调用自测")
    parser.add_argument("input", help="保护的 Lua/Luau 文件")
    parser.add_argument("--version", default="auto", help="auto / 14.7 / 14.8 / 14.9 / 15")
    parser.add_argument("--deobf-dir", default=None, help="上游解混淆器目录")
    parser.add_argument("--trace", action="store_true", help="只生成行为追踪")
    parser.add_argument("--strings", action="store_true")
    parser.add_argument("--debug", action="store_true")
    parser.add_argument("--timeout", type=int, default=150)
    parser.add_argument("--hard-timeout", type=float, default=900)
    parser.add_argument("-o", "--outdir", default=None, help="任务目录（默认 ./.selftest）")
    args = parser.parse_args(argv)

    try:
        deobf_dir = find_deobf_dir(args.deobf_dir)
    except DeobfNotFound as exc:
        print(f"[x] {exc}", file=sys.stderr)
        return 2

    env = check_environment(deobf_dir)
    print(f"[*] 上游目录: {env['deobf_dir']}")
    print(f"[*] Python  : {env['python_version']}")
    print(f"[*] Luau    : {env['luau'] or '缺失'}")
    print(f"[*] luau-ast: {'有' if env['luau_ast'] else '缺失'}")

    workdir = Path(args.outdir or "./.selftest").resolve()
    if workdir.exists():
        shutil.rmtree(workdir, ignore_errors=True)
    src = prepare_input(Path(args.input).resolve(), workdir)
    opt = Options(version=args.version, trace_only=args.trace, strings=args.strings,
                  debug=args.debug, harness_timeout=args.timeout)

    def echo(line: str) -> None:
        print("   | " + line, file=sys.stderr)

    res = asyncio.run(run_job(
        deobf_dir=deobf_dir, src=src, workdir=workdir, opt=opt,
        hard_timeout=args.hard_timeout, on_line=echo,
    ))
    print("-" * 60)
    print(f"结果 : {'成功' if res.ok else '失败'}")
    print(f"前端 : {res.engine}")
    print(f"模式 : {'行为追踪' if res.mode == 'trace' else 'Lua 结果'}")
    print(f"用时 : {res.elapsed:.1f}s   返回码: {res.returncode}")
    if res.output:
        print(f"输出 : {res.output} ({res.size_bytes / 1024:.1f} KB, {res.line_count} 行)")
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
