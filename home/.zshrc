# ============================================================
# 代理配置
# ============================================================

# 代理端口
export PROXY_PORT=7897

# 开启代理（默认 HTTP/HTTPS，可选 socks5）
# 用法:
#   proxy-on          -> 开启 HTTP/HTTPS
#   proxy-on socks5   -> 开启 SOCKS5
proxy-on() {
    local mode="${1:-http}"
    if [[ "$mode" == "socks5" ]]; then
        export all_proxy="socks5://127.0.0.1:$PROXY_PORT"
        unset http_proxy
        unset https_proxy
        echo "SOCKS5 代理已开启，端口 $PROXY_PORT"
    else
        export http_proxy="http://127.0.0.1:$PROXY_PORT"
        export https_proxy="http://127.0.0.1:$PROXY_PORT"
        unset all_proxy
        echo "HTTP/HTTPS 代理已开启，端口 $PROXY_PORT"
    fi
}

# 关闭所有代理
proxy-off() {
    unset http_proxy
    unset https_proxy
    unset all_proxy
    echo "所有代理已关闭"
}

# 查看当前代理状态
proxy-status() {
    echo "http_proxy=$http_proxy"
    echo "https_proxy=$https_proxy"
    echo "all_proxy=$all_proxy"
}

# 快捷开启 SOCKS5
proxy-socks5() {
    proxy-on socks5
}

# ============================================================
# 环境变量
# ============================================================

# 默认编辑器
export EDITOR="nvim"

# LM Studio CLI
export PATH="$PATH:/Users/dcj/.lmstudio/bin"

# Maven
export MAVEN_HOME="/Applications/IntelliJ IDEA.app/Contents/plugins/maven/lib/maven3"
export PATH="$MAVEN_HOME/bin:$PATH"

# Claude Code
export PATH="$HOME/.local/bin:$PATH"

# FlyEnv 管理的 Java 环境
export PATH="/Users/dcj/Library/FlyEnv/alias:/Users/dcj/Library/FlyEnv/env/java:/Users/dcj/Library/FlyEnv/env/java/bin:$PATH"
export JAVA_HOME="/usr"

# ============================================================
# 终端提示符（Starship）
# ============================================================

eval "$(starship init zsh)"

# ============================================================
# Zsh 插件
# ============================================================

# 历史命令灰色透明提示（按右箭头补全）
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# 命令语法高亮（正确绿色，错误红色）
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Docker 命令补全
fpath=(/Users/dcj/.docker/completions $fpath)
autoload -Uz compinit
compinit

# ============================================================
# 目录跳转（zoxide）
# ============================================================
# 用法:
#   z <关键词>   -> 智能跳转到匹配的目录
#   zi           -> 交互式模糊搜索跳转（需要 fzf）
eval "$(zoxide init zsh)"

# ============================================================
# Node.js 版本管理（fnm，启动零延迟）
# ============================================================
# 用法与 nvm 类似:
#   fnm install 20        -> 安装 Node 20
#   fnm use 20            -> 切换到 Node 20
#   fnm default 20        -> 设置默认版本
#   fnm list              -> 查看已安装版本
eval "$(fnm env --use-on-cd --shell=zsh)"

# ============================================================
# 别名 - 常用命令
# ============================================================

alias q='exit'

# ============================================================
# 别名 - 文件列表（eza 替代 ls）
# ============================================================

alias ls='eza --icons --group-directories-first'
alias l='eza -l --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first'
alias y='yazi'

# ============================================================
# 别名 - 系统监控（现代替代工具）
# ============================================================

alias top='btop'       # btop 替代 top
alias ps='procs'       # procs 替代 ps
alias df='duf'         # duf 替代 df
alias iftop='sudo /opt/homebrew/opt/iftop/sbin/iftop'
