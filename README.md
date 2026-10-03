# Luraph 解混淆 Discord 机器人

在 Discord 里发一条指令 + 上传被 **Luraph** 保护的 Roblox Luau 脚本，
机器人自动解混淆，跑完把结果文件发回频道。

```
你：  .deobf   [附：protected.lua]
机器人： 🛠 解混淆任务 #1 ▓▓▓▓▓░░░░░ 42%   🧠 反虚拟化（第 3 轮）
机器人： ✅ 任务 #1 完成   引擎 Luraph v14.7 · 完整反虚拟化 · 18.3 秒 · 92 KB / 2140 行
        📎 protected.deob.lua
```

底层调用 [KryptIT/luraph-v15-v14.x-deobfuscator](https://github.com/KryptIT/luraph-v15-v14.x-deobfuscator)：
**v14.7 / v14.8 / v14.9** 走它的 `cli.py --engine`，**v15** 走 `deob.py --obfuscator luraph_v15`。

---

## 目录里有什么

| 文件 | 作用 |
|---|---|
| `bot.py` | 机器人本体：指令解析、任务队列、进度更新、结果回传 |
| `deobf_runner.py` | 只负责调用解混淆器的一层封装（无 Discord 依赖，可单独命令行用） |
| `selftest.py` | **不连 Discord** 的端到端自测，先证明这台机器能解混淆 |
| `selftest_ui.py` | 用假的 Discord 对象把指令/反应/编号/水印整条链路自检一遍（33 项） |
| `winpause.py` | Windows 双击运行 `.py` 的兜底：开控制台、修编码、结束时等回车（不让窗口闪退） |
| `setup_wizard.py` | 一键安装的实现：查 Python、装依赖、检查/下载解混淆器与 Luau、生成 config、自检 |
| `setup.bat` / `setup.ps1` / `setup.sh` | 三个平台的安装入口（Windows 双击 `setup.bat` 即可；`.ps1`/`.bat` 故意写成**纯 ASCII + CRLF**，避开 cmd/PowerShell 5.1 的代码页与 BOM 问题） |
| `_find_python.bat` | 上面三个 bat 共用的"找 Python"工具：`py -3` → `python` → `python3` → 常见安装目录，并校验版本 ≥ 3.10 |
| `run.bat` / `run.sh` | 启动机器人（失败不自动重启，窗口留着让你看报错） |
| `check.bat` | 双击做环境自检 |
| `config.example.json` | 配置模板（复制成 `config.json`） |
| `vendor/luraph-deobf/` | 上游 KryptIT 解混淆器（固定到 commit `ed79a86`，引擎源码未打本地补丁；省略 Python 缓存和临时运行目录，含 Windows Luau 工具） |
| `从这开始.txt` | 三步快速上手 |
| `work/job-XXXX-XXX/` | 每个任务的输入、完整日志、输出文件（含上面那几份深度清单） |
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

| 结果类型 | 含义 |
|---|---|
| ✅ **完整反虚拟化** | VM 字节码被还原成可读 Luau，含控制流、函数、闭包 |
| 🟡 **行为追踪** | 只包含**这次执行跑到**的代码路径，没执行到的分支不会出现；不是完整还原 |

反面例子：脚本被 obfuscate 后有一堆没跑到的分支，行为追踪里就一条都不会有。
v14.x 如果静态反虚拟化失败，机器人会自动加 `--trace-fallback` 重试一次并标注"回退"。
拿不到完整结果时，先看任务日志和深度捕获附件，并以当前上游引擎的实际输出为准。旧版本地适配使用过的 `DEVIRT_V14_*` 环境变量配方已停用；当前不会再由机器人注入这些样本适配参数。

结果文件顶部统一带水印：`-- deobf by https://discord.gg/ck3k7nAVS`；
解混淆器自带的署名（`Devirtualized with … engine`、`dsc.gg/oxyenv` 等）会被自动去掉。

### 附带的「深度清单」（v14.7 / v14.8 / v14.9 自动带上）

主结果之外，机器人还会再发 1～3 个附件。这些是拿运行时捕获的数据，直接调用解混淆器
自带的调试接口（`devirt.py --raw / --lift`）生成的——**反虚拟化没走到的地方，看这几份**：

| 附件 | 内容 | 为什么有用 |
|---|---|---|
| `<名字>.deob.部分反编译.lua` | 逐块 `--lift` 出来的 Luau 片段，每段单独标注语法检查结果 | 主结果较短时可供辅助分析；片段之间可能不连贯，不能视作完整源码 |
| `<名字>.deob.参考清单.txt` | 从捕获里整理出的 **API/函数引用**（`bit32.*`、`buffer.*`、`hookfunction`…）和**字符串常量**（去重，逐条列出） | 一眼看清这段脚本碰了哪些系统接口、里面写了什么文字 |
| `<名字>.deob.反汇编.txt` | 寄存器级的**逐条反汇编**（每条 VM 指令做了什么、往哪跳） | 主结果缺的字节码在这里能看到；lifter 走不通的位置会标 `!!` |

这些附件的内容和耗时会随样本、上游版本及运行环境变化；附件属于辅助分析材料，不等于完整源码。仓库中的 `样例输出/` 与《适配报告》记录的是旧版本地适配时期的历史结果，不代表当前固定的上游引擎表现。
不想要这几份清单（比如只想省时间）时，设环境变量 `DEOBF_NO_DEEP_CAPTURE=1` 即可关掉。

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
| `max_input_mb` / `max_upload_mb` | `25` / `8` | 输入上限 / 回传上限（超了自动打包 zip，再超就只发前 400 KB 预览） |
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

**只能拿到"行为追踪"**
版本现在是自动识别的（看文件头横幅，没有横幅就按 v14 系列依次试）；
再加大预算：在 config.json 里调 `harness_timeout` / `time_budget` / `devirt_rounds`；
还不行就去看 `work/job-XXXX/log.txt` 里的 `[!]` 警告——多半是"unresolved VM state"，说明这个样本还没被这个解混淆器完全支持。

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
