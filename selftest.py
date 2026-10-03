#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
selftest.py -- 不连 Discord，走完整的"任务队列 -> 解混淆 -> 结果格式化"流程。

用途：先确认这台机器能解混淆，再去配 token。

    python selftest.py                       # 用解混淆器自带的 v15 样本
    python selftest.py 你的脚本.lua --version 14.7
    python selftest.py 你的脚本.lua --keep    # 保留 work/selftest 里的文件
"""
from __future__ import annotations

import argparse
import asyncio
import re
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import bot as B  # noqa: E402   （bot 里已经把控制台/编码兜底装好了）
try:                                          # winpause.py 不在也能跑
    from winpause import run_cli  # noqa: E402
except ImportError:  # pragma: no cover
    def run_cli(fn, argv=None) -> int:
        return int(fn())
from deobf_runner import (DeobfNotFound, Options, check_environment,  # noqa: E402
                          find_deobf_dir, prepare_input)


class FakeStatusMessage:
    """假装是 Discord 的进度消息：edit() 时把 embed 打到终端。"""

    def __init__(self) -> None:
        self.n = 0

    async def edit(self, **kwargs):
        embed = kwargs.get("embed")
        if embed is None:
            return
        self.n += 1
        desc = (embed.description or "").replace("\n", " | ")
        print(f"      [进度 #{self.n}] {embed.title} :: {desc}")
        for f in embed.fields:
            if f.name in ("进度", "最近警告"):
                print(f"                 {f.name}: {f.value}".replace("\n", " "))

    async def reply(self, **kwargs):
        print("      [结果消息] 已发送")


class FakeBot:
    """只实现 JobQueue 需要的部分。"""

    def __init__(self, cfg: dict, deobf_dir: Path) -> None:
        self.cfg = cfg
        self.deobf_dir = deobf_dir
        self.python = cfg.get("python") or sys.executable
        self.work_root = HERE / "work"
        self.work_root.mkdir(exist_ok=True)
        self.job_queue = B.JobQueue(self)

    async def deliver(self, job: B.Job, res) -> None:
        embed = B.result_embed(self, job, res)
        print("\n" + "=" * 62)
        print(embed.title)
        if embed.description:
            print("  " + embed.description.replace("\n", "\n  "))
        for f in embed.fields:
            print(f"  {f.name}: {f.value}".replace("\n", "\n      "))
        print("=" * 62)
        if res.output:
            print(f"结果文件: {res.output}")
            head = res.output.read_text(encoding="utf-8", errors="replace").splitlines()[:12]
            print("-" * 62)
            for line in head:
                print("  | " + line)
            print("-" * 62)


def pick_sample(deobf_dir: Path, version: str = "auto") -> Path | None:
    """挑一个自带的测试样本。指定了版本就优先挑横幅匹配的那个。

    仓库里的样本：
        samples/001_vm_like_dispatch-obfuscated.lua   Luraph v15
        samples/001_vm_like_dispatch-ib1.lua          IronBrew 1
        samples/v14/v14.7.txt|v14.8.txt|v14.9-sample.lua   Luraph v14.x
    """
    samples = deobf_dir.parent / "samples"
    if not samples.is_dir():
        return None

    cands = [p for p in sorted(samples.rglob("*.lua")) + sorted(samples.rglob("*.txt"))
             if "output" not in p.parts
             and ("obfuscated" in p.name or p.name.endswith("-ib1.lua") or "sample" in p.name
                  or p.name.startswith("v14."))]
    if not cands:
        return None

    def banner_of(path: Path) -> str:
        head = path.open("rb").read(2048).decode("latin-1", errors="replace")
        m = re.search(r"Luraph Obfuscator v(\d+(?:\.\d+)?)", head, re.I)
        return m.group(1) if m else ""

    want = (version or "auto").strip().lower().lstrip("v")
    if want and want != "auto":
        # 先精确匹配（14.7 → 横幅 v14.7 的样本），再退回主版本（14 → 任意 14.x）
        for exact in (True, False):
            for p in cands:
                b = banner_of(p)
                if not b:
                    continue
                same = b == want or b.startswith(want + ".")
                major = b.split(".")[0] == want.split(".")[0]
                if (exact and same) or (not exact and major):
                    return p
    # 自动模式：优先 Luraph 样本，其次 ironbrew 样本
    for p in cands:
        if banner_of(p):
            return p
    return cands[0]


async def run(args) -> int:
    cfg = B.load_config(Path(args.config))
    cfg["job_timeout_seconds"] = args.hard_timeout
    try:
        deobf_dir = find_deobf_dir(args.deobf_dir or cfg.get("deobf_dir") or None)
    except DeobfNotFound as exc:
        print(f"[x] {exc}")
        return 2

    env = check_environment(deobf_dir, cfg.get("python") or sys.executable)
    print(f"[*] 解混淆器: {env['deobf_dir']}")
    print(f"[*] Python  : {env['python_version']}    luau: {env['luau'] or '缺失'}")

    src_file = Path(args.input).resolve() if args.input else pick_sample(deobf_dir, args.version)
    if not src_file or not src_file.is_file():
        print("[x] 没有可用的样本，请显式传入一个被保护的脚本路径")
        return 2
    print(f"[*] 样本    : {src_file}  ({src_file.stat().st_size / 1024:.0f} KB)")

    fake = FakeBot(cfg, deobf_dir)
    await fake.job_queue.start()

    workdir = fake.work_root / "selftest"
    if workdir.exists():
        import shutil
        shutil.rmtree(workdir, ignore_errors=True)
    workdir.mkdir(parents=True)
    src = prepare_input(src_file, workdir, keep_name=src_file.name)

    job = B.Job(
        id=fake.job_queue.new_id(), user_id=0, user_name="selftest", guild_id=None,
        channel=None, source_name=src_file.name,
        opt=Options(version=args.version, trace_only=args.trace, strings=args.strings,
                    debug=args.debug, harness_timeout=args.harness_timeout),
        workdir=workdir, src_path=src,
    )
    job.status_msg = FakeStatusMessage()

    print("[*] 入队并等待结束...\n")
    started = time.time()
    await fake.job_queue.queue.put(job)
    await fake.job_queue.queue.join()
    await fake.job_queue.stop()

    ok = bool(job.result and job.result.ok)
    print(f"\n总耗时 {time.time() - started:.1f}s  ->  {'成功' if ok else '失败'}")
    print(f"日志: {workdir / 'log.txt'}")
    if not args.keep and not ok:
        print("（失败时保留文件便于排查）")
    return 0 if ok else 1


def cli() -> int:
    """真正的入口：解析参数再跑（run_cli 需要零参或 argv 版的 main）。"""
    return main()


def main() -> int:
    ap = argparse.ArgumentParser(description="不连 Discord 的端到端自测")
    ap.add_argument("input", nargs="?", help="被保护的脚本（默认用仓库自带样本）")
    ap.add_argument("--version", default="auto", help="auto / 14.7 / 14.8 / 14.9 / 15")
    ap.add_argument("--config", default=str(HERE / "config.json"))
    ap.add_argument("--deobf-dir", default=None)
    ap.add_argument("--trace", action="store_true", help="只要行为追踪")
    ap.add_argument("--strings", action="store_true")
    ap.add_argument("--debug", action="store_true")
    ap.add_argument("--harness-timeout", type=int, default=150)
    ap.add_argument("--hard-timeout", type=float, default=900)
    ap.add_argument("--keep", action="store_true")
    args = ap.parse_args()
    try:
        return asyncio.run(run(args))
    except KeyboardInterrupt:
        return 130


if __name__ == "__main__":
    # 双击运行：跑完/出错都停一下，窗口不会一闪就没
    raise SystemExit(run_cli(cli))
