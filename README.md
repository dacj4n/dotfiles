# dotfiles

个人终端配置文件，使用符号链接管理，支持一键部署。

## 包含的配置

| 配置 | 路径 | 说明 |
|------|------|------|
| Zsh | `~/.zshrc` | Shell 配置（代理、别名、环境变量） |
| Neovim | `~/.config/nvim/` | 基于 LazyVim 的 IDE 级编辑器 |
| WezTerm | `~/.config/wezterm/wezterm.lua` | 终端模拟器 |
| Starship | `~/.config/starship.toml` | 跨平台提示符 |

## 前置依赖

部署前请确保已安装以下工具：

```bash
# macOS（Homebrew）
brew install neovim wezterm starship zoxide eza btop procs duf fnm

# Zsh 插件
brew install zsh-autosuggestions zsh-syntax-highlighting
```

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

## 目录结构

```
dotfiles/
├── install.sh              # 一键部署脚本
├── README.md
└── home/                   # 对应 $HOME 目录
    ├── .zshrc
    └── .config/
        ├── nvim/           # Neovim (LazyVim) 配置
        │   ├── init.lua
        │   ├── lua/
        │   │   ├── config/
        │   │   │   ├── lazy.lua       # 插件管理器
        │   │   │   ├── options.lua    # Neovim 选项
        │   │   │   ├── keymaps.lua    # 快捷键映射
        │   │   │   └── autocmds.lua   # 自动命令
        │   │   └── plugins/           # 插件配置
        │   └── stylua.toml
        ├── wezterm/
        │   └── wezterm.lua
        └── starship.toml
```

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
```

## Zsh 快捷功能

| 命令 | 说明 |
|------|------|
| `proxy-on` | 开启 HTTP 代理 |
| `proxy-on socks5` | 开启 SOCKS5 代理 |
| `proxy-off` | 关闭代理 |
| `proxy-status` | 查看代理状态 |
| `z <关键词>` | 智能目录跳转 |
| `y` | 打开 yazi 文件管理器 |
