#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Windows 下"双击运行 .py"的兜底工具（非 Windows 上全部是空操作）。

解决三个常见问题：

1. **双击 .py 出错时窗口瞬间消失**，什么提示都看不到 —— 出错后自动等回车；
2. **pythonw.exe 启动时没有 stdout/stderr/stdin**（print 直接报错）——
   自动开一个控制台窗口并把标准流接上去；
3. **中文 Windows 控制台（cp936）或输出被重定向时**，日志里的 ✅ / ⏳ / ✓
   会抛 ``UnicodeEncodeError: 'gbk' codec can't encode character``——
   启动时把标准流切成 utf-8 + 容错替换，只掉字符不崩程序。

用法（放在入口脚本最后）::

    if __name__ == "__main__":
        raise SystemExit(run_cli(main))

其中 ``main`` 是返回退出码的函数（可以是 ``main(argv=None)``）。
"""
from __future__ import annotations

import os
import sys
import traceback

IS_WIN = os.name == "nt"

#: 探针字符串：中文 + 状态符号都在里面，只要一种编码编不出来就换 utf-8
_PROBE = "✓ ✗ ⏳ ✅ ❌ 中文 …"

__all__ = [
    "ensure_console", "fix_output_encoding", "launched_by_double_click",
    "pause", "run_cli",
]


# --------------------------------------------------------------------------
# 标准流
# --------------------------------------------------------------------------

def fix_output_encoding() -> None:
    """让 stdout/stderr 一定能打印中文和 emoji（编不出来就换 utf-8 + replace）。"""
    for stream in (sys.stdout, sys.stderr):
        if stream is None:
            continue
        enc = getattr(stream, "encoding", None)
        try:
            _PROBE.encode(enc or "utf-8")
            continue                      # 当前编码够用，不动它
        except (UnicodeEncodeError, LookupError):
            pass
        try:
            stream.reconfigure(encoding="utf-8", errors="replace")
        except Exception:
            pass


def ensure_console() -> None:
    """没有控制台（pythonw.exe）就现开一个，并把 stdin/stdout/stderr 接上去。"""
    if not IS_WIN:
        return
    if sys.stdout is not None and sys.stderr is not None and sys.stdin is not None:
        return
    try:
        import ctypes
        k32 = ctypes.windll.kernel32
        if not k32.GetConsoleWindow():
            k32.AllocConsole()
    except Exception:
        pass
    for name, mode in (("stdin", "r"), ("stdout", "w"), ("stderr", "w")):
        if getattr(sys, name, None) is not None:
            continue
        try:
            dev = "CONIN$" if name == "stdin" else "CONOUT$"
            setattr(sys, name, open(dev, mode, encoding="utf-8", errors="replace",
                                    buffering=1))
        except Exception:
            try:
                setattr(sys, name, open(os.devnull, mode))
            except Exception:
                pass


def _console_process_count() -> int:
    """挂在当前控制台上的进程数。双击 .py 时只有自己 → 1；从 cmd 里跑 → ≥2。"""
    if not IS_WIN:
        return 0
    try:
        import ctypes
        arr = (ctypes.c_uint * 16)()
        n = ctypes.windll.kernel32.GetConsoleProcessList(arr, 16)
        return int(n)
    except Exception:
        return 0


def launched_by_double_click(argv=None) -> bool:
    """猜这次是不是"双击 .py"启动的：Windows + 无参数 + 控制台里只有自己。"""
    if os.environ.get("DEOBF_FORCE_PAUSE") == "1":
        return True
    if os.environ.get("DEOBF_NO_PAUSE") == "1":
        return False
    if not IS_WIN or sys.stdin is None:
        return False
    args = list(sys.argv[1:] if argv is None else argv)
    if args:
        return False
    if _console_process_count() != 1:
        return False
    try:
        return bool(sys.stdin.isatty())
    except Exception:
        return False


# --------------------------------------------------------------------------
# 收尾
# --------------------------------------------------------------------------

def pause(code: int | None = None, reason: str = "") -> None:
    """停在窗口里等回车，让人能看完提示。输入不可用时直接跳过。"""
    if sys.stdin is None:
        return
    lines: list[str] = []
    if reason:
        lines.append(reason)
    if code not in (None, 0):
        lines.append(f"程序以失败退出（退出码 {code}）。")
        lines.append("排查：双击 check.bat 做环境自检；完整日志见 logs\\bot.log。")
    elif code == 0:
        lines.append("程序已结束。")
    lines.append("")
    lines.append("按回车键关闭这个窗口……")
    try:
        print("\n" + "\n".join(lines), flush=True)
    except Exception:
        pass
    try:
        input()
    except (EOFError, KeyboardInterrupt, OSError):
        pass


def run_cli(main, argv=None) -> int:
    """跑入口函数：修好控制台/编码，出错不隐藏，双击时最后停一下。

    ``main`` 要么是零参函数，要么是接受 argv 列表的函数（此时传 ``argv``）。
    """
    ensure_console()
    fix_output_encoding()
    double = launched_by_double_click(argv)

    code = 0
    try:
        code = int(main() if argv is None else main(argv))
    except SystemExit as exc:                     # 入口里可能直接 raise SystemExit("...")
        if isinstance(exc.code, int):
            code = exc.code
        elif exc.code is None:
            code = 0
        else:
            # Python 原生行为：SystemExit("文字") 会把文字打到 stderr。这里被接住了，
            # 所以得自己打，否则出错原因就丢了（双击场景尤其致命）。
            print(exc.code, file=sys.stderr, flush=True)
            code = 1
    except KeyboardInterrupt:
        print("\n已取消。", flush=True)
        code = 130
    except Exception:
        traceback.print_exc()
        print("\n[x] 程序出错了：错误原因就是上面最后一行（完整日志见 logs\\bot.log）。",
              flush=True)
        code = 1

    if double:
        pause(code=code)
    return code
