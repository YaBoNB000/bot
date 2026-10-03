#!/usr/bin/env bash
# Luraph 解混淆机器人 · Linux / macOS 安装入口
# 真正的安装逻辑在 setup_wizard.py 里（三个平台共用一套）。
#
#   bash setup.sh
#   bash setup.sh --deobf-dir /opt/deobf --token "xxx"
set -euo pipefail
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PY=""
for cand in python3 python; do
  if command -v "$cand" >/dev/null 2>&1 && \
     "$cand" -c 'import sys; raise SystemExit(0 if sys.version_info >= (3,10) else 1)' 2>/dev/null; then
    PY="$cand"
    break
  fi
done

if [[ -z "$PY" ]]; then
  printf '\033[31m[x]\033[0m 需要 Python 3.10+（Ubuntu/Debian: sudo apt install python3 python3-pip）\n'
  exit 1
fi

[[ -f setup_wizard.py ]] || { printf '\033[31m[x]\033[0m 缺少 setup_wizard.py（它应该和 setup.sh 在同一个目录）\n'; exit 1; }

exec "$PY" setup_wizard.py "$@"
