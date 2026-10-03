#!/usr/bin/env bash
# 启动机器人（Linux / macOS）。首次使用先跑 bash setup.sh
set -euo pipefail
cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec python3 bot.py "$@"
