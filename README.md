# dotfiles

个人终端配置文件，使用符号链接管理，支持一键部署。

## 包含的配置

| 配置 | 路径 | 说明 |
|------|------|------|
| Zsh | `~/.zshrc` | Shell 配置（代理、别名、环境变量、插件） |
| Neovim | `~/.config/nvim/` | 基于 LazyVim 的 IDE 级编辑器 |
| WezTerm | `~/.config/wezterm/wezterm.lua` | 终端模拟器（分屏、快捷键、透明背景） |
| Starship | `~/.config/starship.toml` | 跨平台 Shell 提示符（显示 Git、语言版本等） |

---

## 前置依赖

部署前请确保已安装以下工具（macOS + Homebrew）：

```bash
# 核心工具
brew install neovim wezterm starship zoxide fnm

# 现代 CLI 替代品（.zshrc 中的别名依赖这些）
brew install eza btop procs duf yazi

# Zsh 插件（命令提示 + 语法高亮）
brew install zsh-autosuggestions zsh-syntax-highlighting

# 可选：网络监控
brew install iftop
```

各依赖的用途：

| 工具 | 用途 | 被谁使用 |
|------|------|---------|
| `neovim` | 现代化 Vim 编辑器 | `EDITOR` 环境变量 |
| `wezterm` | GPU 加速终端模拟器 | 终端程序 |
| `starship` | Shell 提示符 | `.zshrc` |
| `zoxide` | 智能目录跳转（替代 `cd`） | `.zshrc`（`z` 命令） |
| `fnm` | Node.js 版本管理（零延迟） | `.zshrc` |
| `eza` | 现代 `ls` 替代品（图标 + 颜色） | `.zshrc`（`ls`/`l`/`ll` 别名） |
| `btop` | 现代系统监控 | `.zshrc`（`top` 别名） |
| `procs` | 现代 `ps` 替代品 | `.zshrc`（`ps` 别名） |
| `duf` | 现代 `df` 替代品 | `.zshrc`（`df` 别名） |
| `yazi` | 终端文件管理器 | `.zshrc`（`y` 别名） |
| `zsh-autosuggestions` | 历史命令灰色提示（右箭头补全） | `.zshrc` |
| `zsh-syntax-highlighting` | 命令语法高亮（正确绿色、错误红色） | `.zshrc` |

> **注意**：如果缺少某个工具，对应的别名/功能会报错，但不影响其他功能。可以按需安装，或注释掉 `.zshrc` 中对应的行。

---

## 一键部署

```bash
git clone https://github.com/你的用户名/dotfiles.git
cd dotfiles
./install.sh
source ~/.zshrc
```

部署脚本会：
1. 自动备份已有的配置文件（后缀 `.bak.时间戳`）
2. 创建符号链接指向 dotfiles 仓库中的文件
3. 后续修改配置只需编辑 dotfiles 仓库，`git push` 即可同步

---

## 目录结构

```
dotfiles/
├── install.sh                  # 一键部署脚本
├── README.md
└── home/                       # 对应 $HOME 目录
    ├── .zshrc                  # Zsh 配置
    └── .config/
        ├── nvim/               # Neovim (LazyVim) 配置
        │   ├── init.lua        # 入口文件
        │   ├── lazy-lock.json  # 插件版本锁定
        │   ├── lua/
        │   │   ├── config/
        │   │   │   ├── lazy.lua       # lazy.nvim 插件管理器
        │   │   │   ├── options.lua    # Neovim 选项（可自定义）
        │   │   │   ├── keymaps.lua    # 快捷键映射（可自定义）
        │   │   │   └── autocmds.lua   # 自动命令（可自定义）
        │   │   └── plugins/
        │   │       └── example.lua    # 插件配置示例（不会实际加载）
        │   └── stylua.toml            # Lua 格式化配置
        ├── wezterm/
        │   └── wezterm.lua     # WezTerm 终端配置
        └── starship.toml       # Starship 提示符配置
```

---

## 配置详解

### 1. Zsh（`~/.zshrc`）

#### 代理管理

通过本地代理端口（默认 7897）管理网络代理：

```bash
proxy-on            # 开启 HTTP/HTTPS 代理
proxy-on socks5     # 开启 SOCKS5 代理
proxy-off           # 关闭所有代理
proxy-status        # 查看当前代理状态
```

> 如果你的代理端口不是 7897，修改 `.zshrc` 中的 `PROXY_PORT` 变量。

#### 别名

| 别名 | 实际命令 | 说明 |
|------|---------|------|
| `ls` | `eza --icons --group-directories-first` | 带图标的文件列表 |
| `l` | `eza -l --icons ...` | 详细列表 |
| `ll` | `eza -l --icons ...` | 详细列表（同 `l`） |
| `y` | `yazi` | 打开 yazi 文件管理器 |
| `top` | `btop` | 现代系统监控 |
| `ps` | `procs` | 现代 `ps` |
| `df` | `duf` | 现代 `df` |
| `q` | `exit` | 快速退出终端 |

#### 目录跳转

```bash
z <关键词>    # 智能跳转（zoxide 会记住你常去的目录）
zi            # 交互式模糊搜索跳转（需要安装 fzf）
```

#### Node.js 版本管理

```bash
fnm install 20     # 安装 Node 20
fnm use 20         # 切换到 Node 20
fnm default 20     # 设置默认版本
fnm list           # 查看已安装版本
```

#### 环境变量

| 变量 | 值 | 说明 |
|------|---|------|
| `EDITOR` | `nvim` | 默认编辑器（yazi、git 等会使用） |
| `JAVA_HOME` | `/usr` | Java 环境（FlyEnv 管理） |
| `MAVEN_HOME` | IntelliJ 内置 Maven | Maven 路径 |

---

### 2. Neovim（`~/.config/nvim/`）

基于 [LazyVim](https://github.com/LazyVim/LazyVim) 框架，开箱即用的 IDE 级编辑器。

#### 首次使用

```bash
nvim    # 首次打开会自动下载 50+ 插件，需要几分钟
```

#### 核心概念

- **Leader 键**：`<Space>`（空格键），所有自定义快捷键的前缀
- **模式**：`Esc` 回到正常模式，正常模式下按 `<Space>` 触发命令菜单
- **Buffer vs Window**：Buffer 是打开的文件，Window 是屏幕区域。关闭文件用 `<Space>bd`，关闭窗口用 `<C-w>q`

#### 常用快捷键

**文件操作：**

| 快捷键 | 功能 |
|--------|------|
| `<Space>ff` | 模糊搜索文件 |
| `<Space>fw` | 搜索文件内容 |
| `<Space>fg` | 全局搜索（live grep） |
| `<Space>bb` | 列出已打开的文件 |
| `<Space>bd` | 关闭当前文件 |
| `<S-h>` / `<S-l>` | 切换到上一个/下一个文件 |

**编辑器操作：**

| 快捷键 | 功能 |
|--------|------|
| `<Space>qq` | 退出 Neovim |
| `<Esc>` × 2 | 关闭悬浮窗口 |
| `<C-w>h/j/k/l` | 在窗口间跳转 |
| `<C-w>q` | 关闭当前窗口 |

**代码功能（需要 LSP）：**

| 快捷键 | 功能 |
|--------|------|
| `gd` | 跳转到定义 |
| `K` | 查看函数文档 |
| `<Space>ca` | 代码操作（快速修复） |
| `<Space>lf` | 格式化代码 |
| `<Space>lr` | 重命名变量 |

**文件树（neo-tree）：**

| 快捷键 | 功能 |
|--------|------|
| `<Space>e` | 打开/关闭文件树 |
| `<C-w>h` | 跳到文件树窗口 |

#### 自定义配置

| 文件 | 用途 |
|------|------|
| `lua/config/options.lua` | Neovim 选项（缩进、行号等） |
| `lua/config/keymaps.lua` | 自定义快捷键 |
| `lua/config/autocmds.lua` | 自动命令 |
| `lua/plugins/*.lua` | 添加/修改插件（每个文件独立） |

#### 添加语言支持

在 `lua/plugins/` 下新建文件，例如 `lua/plugins/python.lua`：

```lua
return {
  { import = "lazyvim.plugins.extras.lang.python" },
}
```

打开 Neovim 后按 `<Space>lI` 安装 LSP 服务器。

---

### 3. WezTerm（`~/.config/wezterm/wezterm.lua`）

GPU 加速的终端模拟器，支持分屏和透明背景。

#### 快捷键

| 快捷键 | 功能 |
|--------|------|
| `Cmd+R` | 水平分割（左右分屏） |
| `Cmd+D` | 垂直分割（上下分屏） |
| `Cmd+B` 然后 `h/j/k/l` | 调整 Pane 大小（连续按，`Esc` 退出） |
| `Cmd+B` 然后方向键 | 在 Pane 之间切换 |
| `Cmd+B` 然后 `Space` | 当前 Pane 全屏/还原 |
| `Option+←/→` | 按单词移动光标 |

#### 配置特点

- 字体：JetBrains Mono（主字体）+ 黑体/宋体（中文回退）
- 配色：Catppuccin Mocha
- 背景：半透明 + 壁纸（需修改 `wezterm.lua` 中的壁纸路径）
- 窗口大小：160 列 × 45 行
- 滚动回看：30000 行
- 设置标签tab宽度为32以展示更多内容

> **注意**：壁纸路径是硬编码的（`/Volumes/文档/视图/壁纸/...`），部署后需修改为你自己的壁纸路径，或删除 `background` 配置块。

---

### 4. Starship（`~/.config/starship.toml`）

跨平台 Shell 提示符，显示当前上下文信息。

#### 显示内容

```
░▒▓  [用户] [目录路径] [Git 分支 + 状态] [Node/Go/Rust/PHP 版本] [时间]
$                                                              ← 输入命令的位置
```

- 目录路径会缩短显示（最多 3 级）
- 特殊目录有图标替换（Documents → 📁, Downloads → ⬇️ 等）
- Git 仓库中会显示分支名和修改状态
- 检测到项目中的语言环境时显示版本号（Node.js、Go、Rust、PHP）

---

## 日常维护

```bash
# 修改配置后同步到 GitHub
cd dotfiles
git add -A
git commit -m "更新配置"
git push

# 在新机器上恢复
git clone https://github.com/你的用户名/dotfiles.git
cd dotfiles
./install.sh
source ~/.zshrc
```

## 许可证

MIT
