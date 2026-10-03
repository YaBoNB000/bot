#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
setup_wizard.py -- 一键安装环境（Windows / Linux / macOS 通用）

做这些事：
  1. 检查 Python 版本
  2. pip install -r requirements.txt
  3. 下载 KryptIT/luraph-v15-v14.x-deobfuscator 到 vendor/luraph-deobf
  4. 准备 Luau 运行时（Windows 版仓库自带；Linux/macOS 自动下载官方版）
  5. 生成 config.json
  6. 跑一次环境自检

普通用户不用直接调用它：
    Windows     双击 setup.bat，或 powershell -ExecutionPolicy Bypass -File setup.ps1
    Linux/macOS bash setup.sh
"""
from __future__ import annotations

import argparse
import json
import os
import shutil
import subprocess
import sys
import tempfile
import urllib.error
import urllib.request
import zipfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
VENDOR = HERE / "vendor" / "luraph-deobf"
REPO_URL = "https://github.com/KryptIT/luraph-v15-v14.x-deobfuscator"
ZIP_URL = REPO_URL + "/archive/refs/heads/main.zip"
LUAU_RELEASE = "https://github.com/luau-lang/luau/releases/latest/download/"

IS_WIN = os.name == "nt"
TOTAL_STEPS = 6


# ---------------------------------------------------------------- 输出小工具
def setup_console() -> None:
    """让中文在 Windows 控制台里正常显示（失败也不影响安装）。"""
    if IS_WIN:
        try:
            os.system("chcp 65001 >nul 2>nul")
        except Exception:
            pass
    for stream in (sys.stdout, sys.stderr):
        try:
            stream.reconfigure(encoding="utf-8", errors="replace")
        except Exception:
            pass


def step(n: int, msg: str) -> None:
    print(f"\n[{n}/{TOTAL_STEPS}] {msg}", flush=True)


def ok(msg: str) -> None:
    print(f"    [+] {msg}", flush=True)


def warn(msg: str) -> None:
    print(f"    [!] {msg}", flush=True)


def die(msg: str) -> "None":
    print(f"\n[x] {msg}", file=sys.stderr, flush=True)
    sys.exit(1)


def run(cmd: list[str], **kw) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, text=True, encoding="utf-8", errors="replace",
                          capture_output=True, **kw)


def version_tuple() -> tuple[int, int]:
    return sys.version_info[0], sys.version_info[1]


# ---------------------------------------------------------------- 各步骤实现
def have_deobf(path: Path) -> bool:
    return (path / "deob.py").is_file() and (path / "cli.py").is_file() \
        and (path / "obfuscators").is_dir()


def find_local_deobf(explicit: str | None) -> Path | None:
    cands: list[Path] = []
    if explicit:
        cands.append(Path(explicit).expanduser())
    if os.environ.get("DEOBF_DIR"):
        cands.append(Path(os.environ["DEOBF_DIR"]).expanduser())
    cands += [
        VENDOR / "Deobfuscator" / "deobf",
        HERE / "Deobfuscator" / "deobf",
        HERE / "deobf",
    ]
    for c in cands:
        try:
            if have_deobf(c.resolve()):
                return c.resolve()
        except OSError:
            continue
    return None


def install_deobf(method: str, force: bool) -> Path:
    target = VENDOR / "Deobfuscator" / "deobf"
    if have_deobf(target) and not force:
        ok(f"用已有的：{target}")
        return target
    if VENDOR.exists() and force:
        shutil.rmtree(VENDOR, ignore_errors=True)

    use_git = method in ("auto", "git") and shutil.which("git") is not None
    if method == "git" and shutil.which("git") is None:
        warn("指定了 --method git，但系统里没有 git，改用 zip 下载")

    VENDOR.parent.mkdir(parents=True, exist_ok=True)

    if use_git:
        print("    [*] git clone ...（约 15 MB，稍等）", flush=True)
        proc = subprocess.run(["git", "clone", "--depth", "1", REPO_URL + ".git", str(VENDOR)],
                              capture_output=True, text=True, encoding="utf-8", errors="replace")
        if proc.returncode != 0 or not have_deobf(target):
            warn("git clone 失败，改用 zip 下载")
            shutil.rmtree(VENDOR, ignore_errors=True)
            use_git = False

    if not use_git:
        print("    [*] 下载 main.zip ...（约 15 MB，稍等）", flush=True)
        tmp = Path(tempfile.mkdtemp(prefix="luraph-deobf-"))
        try:
            archive = tmp / "main.zip"
            try:
                urllib.request.urlretrieve(ZIP_URL, archive)
            except (urllib.error.URLError, OSError) as exc:
                die(f"下载失败：{exc}\n"
                    f"    手动方案：用浏览器打开 {ZIP_URL}\n"
                    f"    解压后把里面的文件夹改名成 vendor/luraph-deobf（放在本目录下即可）")
            print("    [*] 解压 ...", flush=True)
            with zipfile.ZipFile(archive) as z:
                z.extractall(tmp / "x")
            inner = None
            for p in (tmp / "x").iterdir():
                if p.is_dir() and (p / "Deobfuscator").is_dir():
                    inner = p
                    break
            if inner is None:
                die("压缩包结构不对，没找到 Deobfuscator 目录")
            shutil.rmtree(VENDOR, ignore_errors=True)
            shutil.move(str(inner), str(VENDOR))
        finally:
            shutil.rmtree(tmp, ignore_errors=True)

    if not have_deobf(target):
        die(f"安装后没找到解混淆器：{target}")
    ok(f"解混淆器就绪：{target}")
    return target


def ensure_luau(deobf: Path) -> None:
    bin_dir = deobf / "bin"
    bin_dir.mkdir(parents=True, exist_ok=True)
    exe = "luau.exe" if IS_WIN else "luau"
    ast = "luau-ast.exe" if IS_WIN else "luau-ast"

    if (bin_dir / exe).is_file():
        ok(f"Luau 运行时已就绪：{bin_dir / exe}")
        if not (bin_dir / ast).is_file():
            warn("缺少 luau-ast（大脚本做反虚拟化时会需要）")
        return

    if IS_WIN:
        zipname, wanted = "luau-windows.zip", ["luau.exe", "luau-ast.exe"]
    elif sys.platform == "darwin":
        zipname, wanted = "luau-macos.zip", ["luau", "luau-ast"]
    else:
        zipname, wanted = "luau-ubuntu.zip", ["luau", "luau-ast"]

    print(f"    [*] 下载官方 Luau 运行时（{zipname}）...", flush=True)
    tmp = Path(tempfile.mkdtemp(prefix="luau-"))
    try:
        archive = tmp / "luau.zip"
        try:
            urllib.request.urlretrieve(LUAU_RELEASE + zipname, archive)
            with zipfile.ZipFile(archive) as z:
                names = z.namelist()
                for name in wanted:
                    match = next((n for n in names if Path(n).name == name), None)
                    if match:
                        with z.open(match) as src, open(bin_dir / name, "wb") as dst:
                            shutil.copyfileobj(src, dst)
                        if not IS_WIN:
                            os.chmod(bin_dir / name, 0o755)
        except (urllib.error.URLError, OSError, zipfile.BadZipFile) as exc:
            warn(f"Luau 下载失败：{exc}")
            if IS_WIN:
                warn("手动方案：从 luau-lang/luau 的 Releases 下 luau-windows.zip，"
                     f"把 luau.exe 和 luau-ast.exe 放进 {bin_dir}")
            else:
                warn("手动方案：系统里装一个 luau（或从 luau-lang/luau Releases 下载对应平台包），"
                     f"把 luau 和 luau-ast 放进 {bin_dir}")
            warn("注意：官方 Linux/macOS 版的 vector 元表是只读的，遇到 v:Dot / v.Magnitude "
                 "报错时需要用仓库自带的补丁脚本编译：python3 deobf/build_luau.py")
            return
    finally:
        shutil.rmtree(tmp, ignore_errors=True)

    if (bin_dir / exe).is_file():
        ok(f"Luau 运行时就绪：{bin_dir / exe}")
        if not IS_WIN:
            warn("官方 Linux/macOS 构建的 vector 元表是只读的；遇到 v:Dot / v.Magnitude 报错时，"
                 "用 python3 deobf/build_luau.py 编译补丁版（需 git + cmake + 编译器）")
    else:
        warn(f"没能准备好 {exe}，放进 {bin_dir} 后重跑本脚本即可")


def write_config(deobf: Path, token: str) -> Path:
    cfg_path = HERE / "config.json"
    example = HERE / "config.example.json"
    if cfg_path.is_file():
        try:
            cfg = json.loads(cfg_path.read_text(encoding="utf-8-sig"))
        except json.JSONDecodeError:
            warn("现有 config.json 解析失败，备份为 config.json.bak 后重建")
            shutil.copyfile(cfg_path, HERE / "config.json.bak")
            cfg = {}
        changed = False
        if not str(cfg.get("deobf_dir") or "").strip() or not have_deobf(Path(str(cfg["deobf_dir"]))):
            cfg["deobf_dir"] = str(deobf)
            changed = True
        if token and not str(cfg.get("token") or "").strip():
            cfg["token"] = token
            changed = True
        if changed:
            cfg_path.write_text(json.dumps(cfg, ensure_ascii=False, indent=2), encoding="utf-8")
            ok(f"更新了 {cfg_path}")
        else:
            ok("config.json 已存在且配置正确，未改动")
        return cfg_path

    if not example.is_file():
        die(f"缺少 {example}，请确认 luraph-bot 的所有文件都在同一个目录里")
    cfg = json.loads(example.read_text(encoding="utf-8-sig"))
    cfg["deobf_dir"] = str(deobf)
    if token:
        cfg["token"] = token
    cfg_path.write_text(json.dumps(cfg, ensure_ascii=False, indent=2), encoding="utf-8")
    ok(f"已生成 {cfg_path}")
    return cfg_path


def pip_install(skip: bool) -> None:
    if skip:
        warn("按参数要求跳过依赖安装")
        return
    req = HERE / "requirements.txt"
    if not req.is_file():
        warn("没有 requirements.txt，跳过（机器人至少需要 discord.py）")
        return
    print("    [*] pip install discord.py ...", flush=True)
    proc = run([sys.executable, "-m", "pip", "install", "--disable-pip-version-check",
                "-q", "-r", str(req)])
    if proc.returncode != 0:
        tail = (proc.stderr or proc.stdout or "").strip().splitlines()[-6:]
        warn("安装失败：" + "\n      ".join(tail))
        warn("国内网络可以换镜像重试：")
        warn(f"    {sys.executable} -m pip install -r requirements.txt "
             f"-i https://pypi.tuna.tsinghua.edu.cn/simple")
        warn("（先继续后面的步骤，补装完依赖再启动机器人）")
    else:
        ok("依赖安装完成（discord.py）")


def check_python() -> None:
    ver = ".".join(str(x) for x in version_tuple())
    if version_tuple() < (3, 10):
        die(f"Python {ver} 太旧，需要 3.10+（建议 3.12/3.13）。\n"
            f"    当前解释器：{sys.executable}")
    ok(f"Python {ver}（{sys.executable}）")


def final_check() -> tuple[bool, list[str]]:
    """跑 bot.py --check，返回 (是否可用, 未通过项)。缺 token 不算致命。"""
    bot = HERE / "bot.py"
    if not bot.is_file():
        warn(f"没找到 {bot}，跳过自检")
        return False, [f"缺少 {bot}"]
    proc = run([sys.executable, str(bot), "--check"])
    print(proc.stdout.rstrip())
    problems = [l.strip()[3:].strip() for l in proc.stdout.splitlines()
                if l.strip().startswith("[x]")]
    if not problems:
        return True, []
    fatal = [p for p in problems if "token" not in p.lower()]
    if fatal:
        print("    [!] 自检有未通过项（上面带 [x] 的行）")
    return not fatal, problems


# ---------------------------------------------------------------- 入口
def main(argv: list[str] | None = None) -> int:
    setup_console()
    ap = argparse.ArgumentParser(description="解混淆机器人的一键安装")
    ap.add_argument("--token", default="", help="顺手写进 config.json 的机器人 token")
    ap.add_argument("--deobf-dir", default=None, help="已有解混淆器的路径（跳过下载）")
    ap.add_argument("--method", choices=("auto", "git", "zip"), default="auto")
    ap.add_argument("--force", action="store_true", help="重新下载解混淆器")
    ap.add_argument("--skip-deps", action="store_true", help="跳过 pip install")
    args = ap.parse_args(argv)

    print("=" * 62)
    print(" Luraph 解混淆 Discord 机器人 · 安装")
    print(" 项目目录：" + str(HERE))
    print("=" * 62)

    step(1, "检查 Python")
    check_python()

    step(2, "安装 Python 依赖")
    pip_install(args.skip_deps)

    step(3, "准备解混淆器（KryptIT/luraph-v15-v14.x-deobfuscator）")
    existing = None if args.force else find_local_deobf(args.deobf_dir)
    if existing:
        deobf = existing
        ok(f"用已有的：{deobf}")
    else:
        deobf = install_deobf(args.method, args.force)

    step(4, "准备 Luau 运行时")
    ensure_luau(deobf)

    step(5, "生成配置 config.json")
    cfg_path = write_config(deobf, args.token)

    step(6, "环境自检")
    usable, problems = final_check()
    only_token = bool(problems) and all("token" in p.lower() for p in problems)

    print("\n" + "=" * 62)
    if usable and only_token:
        print(" 安装完成 ✓（只差填 token）")
    elif usable:
        print(" 安装完成 ✓")
    else:
        print(" 安装未完成：上面 [x] 行就是要解决的问题")
    print("-" * 62)
    print(" 解混淆器 : " + str(deobf))
    print(" 配置文件 : " + str(cfg_path))
    try:
        token_set = bool(json.loads(cfg_path.read_text(encoding="utf-8-sig")).get("token"))
    except Exception:
        token_set = False
    env_token = bool(os.environ.get("DISCORD_TOKEN"))
    if token_set or env_token:
        print(" token    : 已配置 ✓")
    else:
        print(" token    : ✗ 还没填")
        print("            Windows : 用记事本打开 config.json，填 \"token\" 这一项")
        print("            Linux   : 编辑 config.json，或设 export DISCORD_TOKEN=...")
    print("-" * 62)
    print(" 下一步：")
    print("   Windows : 双击 run.bat（自测可先跑 py selftest.py）")
    print("   Linux   : bash run.sh（自测可先跑 python3 selftest.py）")
    print("   用法    : 在 Discord 频道里发  .deobf  + 脚本附件（版本自动识别，.help 看指令）")
    print("=" * 62)
    return 0 if usable else 1


def cli() -> int:
    try:
        return main()
    except KeyboardInterrupt:
        print("\n已取消", file=sys.stderr)
        return 130


if __name__ == "__main__":
    try:
        from winpause import run_cli
    except ImportError:                      # winpause.py 不在也一样能跑
        raise SystemExit(cli())
    # 双击 setup_wizard.py / 被双击的 bat 调用：结束后停一下，能看完结果再关
    raise SystemExit(run_cli(cli))
