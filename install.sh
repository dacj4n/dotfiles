#!/bin/bash
# ============================================================
#  dotfiles 一键部署脚本
#  用法: ./install.sh
# ============================================================

set -e

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 脚本所在目录（dotfiles/home/ 的上级）
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_DIR="$DOTFILES_DIR/home"
TARGET_DIR="$HOME"

echo -e "${GREEN}=== dotfiles 部署开始 ===${NC}"
echo "源目录: $SOURCE_DIR"
echo "目标目录: $TARGET_DIR"
echo ""

# 备份函数：如果目标文件已存在，先备份
backup_if_exists() {
    local target="$1"
    if [[ -e "$target" ]]; then
        local backup="${target}.bak.$(date +%Y%m%d%H%M%S)"
        echo -e "${YELLOW}[备份] $target -> $backup${NC}"
        mv "$target" "$backup"
    fi
}

# 创建符号链接的函数
link_file() {
    local src="$1"
    local rel_path="$2"
    local dest="$TARGET_DIR/$rel_path"

    # 确保目标目录存在
    mkdir -p "$(dirname "$dest")"

    # 备份已有文件
    backup_if_exists "$dest"

    # 创建符号链接
    ln -sf "$src" "$dest"
    echo -e "${GREEN}[链接] $rel_path${NC}"
}

# 遍历 home/ 目录下的所有文件和目录
cd "$SOURCE_DIR"
find . -type f | while read -r file; do
    # 去掉开头的 ./
    rel_path="${file#./}"
    src_file="$SOURCE_DIR/$rel_path"
    link_file "$src_file" "$rel_path"
done

echo ""
echo -e "${GREEN}=== 部署完成 ===${NC}"
echo ""
echo "已部署的配置："
echo "  ~/.zshrc              -> Zsh 配置"
echo "  ~/.config/nvim/       -> Neovim (LazyVim) 配置"
echo "  ~/.config/wezterm/    -> WezTerm 终端配置"
echo "  ~/.config/starship.toml -> Starship 提示符配置"
echo ""
echo -e "${YELLOW}提示:${NC}"
echo "  1. 执行 source ~/.zshrc 使配置生效"
echo "  2. 首次打开 nvim 会自动安装插件"
echo "  3. 如需恢复旧配置，备份文件后缀为 .bak.时间戳"
