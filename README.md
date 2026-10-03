# Luraph 解混淆 Discord 机器人

在 Discord 里发一条指令 + 上传被 **Luraph** 保护的 Roblox Luau 脚本，
机器人自动解混淆；成功时只回传主结果 Lua 脚本（大文件可能用只含该脚本的 zip）。

```
你：  .deobf   [附：protected.lua]
机器人： 🛠 任务 XXXX-XXX · 正在运行上游解混淆器
机器人： ✅ 任务 XXXX-XXX 完成 · 上游已生成主 Lua 结果
        📎 protected.deob.lua
```

结果大小与完整程度取决于上游引擎和输入样本；完成状态不保证已完整还原。

底层调用 [KryptIT/luraph-v15-v14.x-deobfuscator](https://github.com/KryptIT/luraph-v15-v14.x-deobfuscator)：
**v14.7 / v14.8 / v14.9** 走它的 `cli.py --engine`，**v15** 走 `deob.py --obfuscator luraph_v15`。

---

## 目录里有什么

| 文件 | 作用 |
|---|---|
| `bot.py` | 机器人本体：指令解析、任务队列、进度更新、结果回传 |
| `deobf_runner.py` | 直接调用上游 CLI、管理进程和记录日志（无 Discord 依赖，可单独命令行用）；不改写输出 |
| `selftest.py` | **不连 Discord** 的端到端自测，先证明这台机器能解混淆 |
| `selftest_ui.py` | 用假的 Discord 对象检查指令、反应、主 Lua 文件筛选/回传及上游前端路由 |
| `winpause.py` | Windows 双击运行 `.py` 的兜底：开控制台、修编码、结束时等回车（不让窗口闪退） |
| `setup_wizard.py` | 一键安装的实现：查 Python、装依赖、检查/下载解混淆器与 Luau、生成 config、自检 |
| `setup.bat` / `setup.ps1` / `setup.sh` | 三个平台的安装入口（Windows 双击 `setup.bat` 即可；`.ps1`/`.bat` 故意写成**纯 ASCII + CRLF**，避开 cmd/PowerShell 5.1 的代码页与 BOM 问题） |
| `_find_python.bat` | 上面三个 bat 共用的"找 Python"工具：`py -3` → `python` → `python3` → 常见安装目录，并校验版本 ≥ 3.10 |
| `run.bat` / `run.sh` | 启动机器人（失败不自动重启，窗口留着让你看报错） |
| `check.bat` | 双击做环境自检 |
| `config.example.json` | 配置模板（复制成 `config.json`） |
| `vendor/luraph-deobf/` | 上游 KryptIT 解混淆器（固定到 commit `ed79a86`，引擎源码未打本地补丁；省略 Python 缓存和临时运行目录，含 Windows Luau 工具） |
| `从这开始.txt` | 三步快速上手 |
| `work/job-XXXX-XXX/` | 任务输入、上游日志和主 Lua 输出；Discord 只回传主 Lua 输出 |
| `logs/bot.log` | 机器人运行日志 |

---

## 快速开始（Windows）

```powershell
# 1. 双击 setup.bat（解混淆器已打包，所以这步只是装依赖 + 生成配置 + 自检），或：
powershell -ExecutionPolicy Bypass -File setup.ps1 -Token "你的机器人token"

# 2. 自测（不连 Discord，会拿解混淆器自带样本跑一遍）
py selftest.py

# 3. 启动
run.bat
```

安装脚本会自动把解混淆器下载到 `vendor\luraph-deobf`（有 git 就用 git，没有就下 main.zip），
里面的 `bin\luau.exe` 是作者编译的**补丁版 Luau**，Windows 上开箱即用。

**Linux / macOS**：`bash setup.sh` 然后 `bash run.sh`（脚本会额外下载官方 Linux/macOS 版 Luau；
打包里带的是 Windows 的 `luau.exe`）。

> 解混淆器已经放在 `vendor/luraph-deobf/`，`config.json` 的 `deobf_dir` 留空也能自动找到它。
> 想更新解混淆器：删掉 `vendor/luraph-deobf` 再跑一次安装脚本（`-Force` 可以强制重下）。

### 建机器人的几步（Discord 开发者后台）

1. https://discord.com/developers/applications → New Application → **Bot** → Reset Token，复制 token。
2. 同一个 Bot 页面里打开 **Privileged Gateway Intents → Message Content Intent**（必开，否则读不到 `.deobf/...`）。
3. **OAuth2 → URL Generator**：勾 `bot` + `applications.commands`，Bot Permissions 勾
   `Send Messages`、`Attach Files`、`Read Message History`、`Embed Links`、`Use Slash Commands`；
   生成的链接打开，把机器人拉进你的服务器。
4. `config.json` 里填 token（或 `set DISCORD_TOKEN=...`），启动即可。
5. 想立刻用上 `/deobf` 斜杠命令：在 `config.json` 里把 `sync_guild_id` 填成服务器 ID
   （服务器 ID 复制不容易，开开发者模式 → 右键服务器 → 复制服务器 ID）。留 0 则全局同步，可能要等 1 小时。

---

## Windows 上怎么启动（双击就行）

| 双击 | 作用 |
|---|---|
| `setup.bat` | 一次性安装：查 Python、装 discord.py、检查解混淆器、生成 `config.json`、自检 |
| `run.bat` | 启动机器人。**出问题不会一闪而过**：失败时留在窗口里等你按回车 |
| `check.bat` | 环境自检（Python / 解混淆器 / luau / token 逐项检查，带 `[x]` 的就是要修的） |

- `run.bat` 正常停止（Ctrl+C）会在 5 秒后自动重启；**启动失败则不会重启**，避免刷屏。
- 带参数时只跑一次，例如 `run.bat --check`。
- 直接双击 `bot.py` / `selftest.py` 也能用：结束后窗口会等回车，不会闪退（内部调用 `winpause.py`）。
- 这三个脚本都是**纯 ASCII + CRLF**（`_find_python.bat` 负责找 Python，会校验版本 ≥ 3.10），
  中文提示都放在 Python 里打印，避免 cmd 代码页/编码把脚本本身搞坏。

## 指令

| 指令 | 说明 |
|---|---|
| `.deobf` + 附件 | **唯一的主指令**：自动识别 Luraph 版本并解混淆，结果发回频道 |
| `.help` | 指令列表（极简：命令 → 作用） |
| `/deobf` | 斜杠命令版（只选文件，版本自动识别） |
| `/help` | 同 `.help` |
| `/stats` | 队列、并发、当前任务 |

发指令时机器人会在**你那条消息**上挂一个 ⏳（加载中），任务结束后换成 ✅ / ❌。

`trace` / `strings` / `debug` 这几个旧参数**已经移除**（再用会提示"已移除"）。
`.deobf/14.7` 这类老写法还能发，但版本号会被忽略——版本一律自动识别。

前缀和指令名可改：`config.json` 里的 `prefixes`（默认 `.` `!`）和 `commands`（默认 `deobf` `deob` `help`），
所以 `!deobf`、`!help` 也都认。

任务进行中，状态消息下面有 **🛑 取消任务** 按钮（提交者或管理员可点）；跑完之后同一个位置会变成 **📎 重新发送结果**（重启机器人后依然可用）。

---

## 结果怎么看

机器人交付的是**上游 CLI 写出的主 Lua 文件**。收到 ✅ 表示上游产出了可发送文件，**不等于保证完整恢复**；文件可能是静态反虚拟化结果，也可能是上游注明的行为追踪或部分结果。行为追踪仅覆盖样本本次实际执行到的路径。

调用路径保持精简：v14.x 使用上游 `cli.py`（并启用其官方 `--trace-fallback` 选项），v15 使用上游 `deob.py --obfuscator luraph_v15`，其他输入交给 `deob.py` 自动识别。每个任务只启动一次上游前端，不在 bot 侧做版本重试、输出评分/改写或深度捕获。Lua 文件内容按上游原样交付；可能保留上游自身的注释或署名。Discord 只发送主 Lua 文件；文件超过上传限制时，尝试发送仅包含该 Lua 文件的 ZIP，ZIP 仍超限则不发送截断预览。日志保存在服务器 `work/job-XXXX-XXX/log.txt`，不会作为附件发送。

**能力边界示例：**本次自测（2026-10-03）中，随仓库提供的 v14.7 / v14.8 / v14.9 三个样本，经固定上游 CLI（v14 使用其官方 `--trace-fallback`）分别产出 3 行 / 70 字节、7 行 / 301 字节、13 行 / 558 字节的行为追踪结果，不是完整源码。这只描述这三个 bundled sample 与本次运行，不能据此推断其他样本；换一种封装去调用同一上游版本也不会改变引擎能力。

仓库中的 `样例输出/` 与《适配报告》是旧版本地适配时期的历史材料，不代表当前固定上游引擎的表现。旧版本地适配使用过的 `DEVIRT_V14_*` 环境变量配方已停用。

---

## 配置项（`config.json`）

| 键 | 默认 | 说明 |
|---|---|---|
| `token` | `""` | 机器人 token；也可用环境变量 `DISCORD_TOKEN` |
| `deobf_dir` | `""` | 解混淆器根目录；留空自动找（也可用环境变量 `DEOBF_DIR`） |
| `python` | `""` | 用哪个 Python 去跑解混淆器；留空＝当前解释器 |
| `prefixes` / `commands` | `[".","!"]` / `["deobf","deob"]` | 指令前缀与指令名 |
| `max_concurrent_jobs` | `1` | 同时跑几个任务。解混淆很吃 CPU，建议 1~2 |
| `queue_size` | `20` | 队列上限，满了直接拒绝 |
| `user_cooldown_seconds` | `60` | 每人提交冷却 |
| `max_input_mb` / `max_upload_mb` | `25` / `8` | 输入上限 / Lua 结果回传上限；超限时 zip 只包含主 Lua 文件，压缩后仍超限则不发送截断预览 |
| `harness_timeout` | `150` | 传给解混淆器的单次运行超时（秒） |
| `time_budget` | `30` | 被追踪脚本的时间预算（秒） |
| `devirt_rounds` / `max_runs` | `200` / `12` | 反虚拟化轮数 / 陷阱重跑次数上限 |
| `job_timeout_seconds` | `900` | 机器人侧的硬超时，到点连 luau 一起杀掉 |
| `progress_interval_seconds` | `8` | 进度消息刷新间隔 |
| `allowed_guild_ids` / `allowed_user_ids` | `[]` | 白名单，留空＝不限制 |
| `allow_dm` | `true` | 是否允许私聊使用 |
| `ephemeral_results` | `false` | 斜杠命令结果是否只有自己可见 |
| `keep_work` | `true` | 保留 `work/job-XXXX/` 里的输入与日志；`false` 则任务结束后删掉上传的原脚本（结果和日志留着） |
| `sync_guild_id` | `0` | 填服务器 ID 可让斜杠命令立刻生效 |

---

## 命令行的用法（不经过 Discord）

```bash
# 环境自检
python bot.py --check

# 端到端自测（默认用解混淆器自带样本）
python selftest.py
python selftest.py 你的脚本.lua --version 14.7
python selftest.py 你的脚本.lua --version 15 --trace --strings

# 直接调解混淆层（等价于机器人在做的事）
python deobf_runner.py protected.lua --version 14.7 --deobf-dir vendor/luraph-deobf/Deobfuscator/deobf
python deobf_runner.py protected.lua --version auto -o ./myjob
```

`selftest.py` 的输出和机器人在频道里发的消息是同一套（用的是同一个 `result_embed`），
所以它跑通 = 机器人也能跑通。

---

## 常见问题

**双击 bat 报错 / 窗口一闪就没了**
1) 先双击 `check.bat`：它会逐项检查 Python、解混淆器、`luau`、token，带 `[x]` 的行就是问题所在。
2) 报 `'python' 不是内部或外部命令` 或 `Python 3.10+ was not found` → 装 Python 3.12
   <https://www.python.org/downloads/windows/>，安装时**勾上 "Add python.exe to PATH"**，
   然后重跑 `setup.bat`（`_find_python.bat` 也会去 `%LOCALAPPDATA%\Programs\Python\Python3*`
   里找，不一定非要 PATH）。
3) 报 `python is older than 3.10` → 版本太旧，装 3.12 后重试（脚本会把你现在这个版本号打出来）。
4) 从**压缩包预览窗口**里直接运行 bat 会报文件缺失/路径错误 —— 先把整个 zip 解压到一个文件夹。
   网络盘（`\\server\share`）也一样，脚本会提示你先复制到本地磁盘。
5) 双击 `bot.py` / `selftest.py` 不再闪退：结束时窗口会等你按回车（`winpause.py`）。
   排查完按回车关掉窗口，或者直接双击 `run.bat`。

**找不到 Luau 运行时 / `luau not found`**
Windows 用安装脚本下载的仓库自带 `bin\luau.exe`。Linux/macOS 官方 Luau 的 vector 元表是只读的，
遇到 `v:Dot` / `v.Magnitude` 报错时，用作者提供的补丁版运行时重新编译：
`python deobf/build_luau.py`（需要 git + cmake + C++ 编译器，Windows 用 MSVC 开发者命令行）。

**机器人没反应**
1) Bot 页面里 **Message Content Intent** 开了吗？2) 指令有没有拼错（`.deobf` / `.help`）？
3) 附件是不是 `.lua/.luau/.txt`？4) `logs/bot.log` 里有 `on_message` 相关报错吗？

**机器人一启动就退出 / 反复重启**
新版 `run.bat` 只在**正常停止**（Ctrl+C）后才自动重启；启动失败会停下来把原因留在窗口里。
常见原因：token 空着或写错（提示会说明）、没开 Message Content Intent、网络连不上 Discord。
这三种情况 `bot.py` 都会用中文说清楚，窗口也不会关，照着做就行。

**只能拿到"行为追踪"或结果不完整**
版本有横幅时按横幅选择上游前端；无横幅时，疑似 v14 的输入交给上游 `cli.py` 自己识别，其他输入交给上游 `deob.py` 自动识别。bot 不会跨版本重试或用本地恢复算法补结果。可以按需调整 `harness_timeout` / `time_budget` / `devirt_rounds`，并查看 `work/job-XXXX-XXX/log.txt`；上游仍可能无法完整恢复该样本。

**同一个文件别人也能用吗？**
能，机器人的权限用 `allowed_guild_ids` / `allowed_user_ids` 控制。

**更新解混淆器**
当前 `vendor/luraph-deobf/` 是仓库内固定快照（commit 见 `vendor/luraph-deobf/UPSTREAM.md`），不是独立 Git checkout，不能在其中直接 `git pull`。若要升级，请选择新的上游 commit 替换快照、更新 pin，并重新跑自测；不要把历史适配报告当成新版本的保证。

---

## 安全与合规（重要）

- **权限要收紧**：解混淆是重 CPU 操作，也是别人可以拿来"白嫖你的机器"的入口。
  线上用的话，务必设置 `allowed_guild_ids` / `allowed_user_ids`，保持 `max_concurrent_jobs: 1`。
- **被跑的脚本是别人的代码**：这个解混淆器是在**真实 Luau VM** 里跑样本（对着假的 Roblox/执行器环境，
  不联网、不碰 Roblox），并在超时/取消时强杀进程树。但它毕竟在你的机器上执行第三方脚本，
  建议放在独立用户 / 虚拟机 / 容器里跑，别和你的主力环境混在一起。
- **不要泄露 token**：`config.json` 已在 `.gitignore` 里。token 泄露 ＝ 别人完全控制你的机器人，泄露了就去开发者后台 Reset。
- **只用于你拥有或有权分析的代码**：这套工具本身面向研究、互操作和逆向分析；
  拿去扒别人的付费脚本可能违反原作者条款和平台规则，后果自己承担。解混淆器作者也声明与 Luraph 官方无关。

---

## 出问题时给我看什么

1. `check.bat`（或 `python bot.py --check`）的输出
2. `logs/bot.log` 最后 50 行
3. 对应任务的 `work/job-XXXX/log.txt`（里面有解混淆器的全部输出）
4. 复现用的最小样本 + 你用的指令
