#!/usr/bin/env sh
# ============================================================
# zsh-config 安装脚本（面向新机器）
# 将本仓库 symlink 到标准位置，并生成本机私有配置模板
# 用法: ./install.sh
# ============================================================
set -eu

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CFG="${XDG_CONFIG_HOME:-$HOME/.config}"

backup_if_real() {
  # $1 = 目标路径；若存在且非 symlink，则先改名备份
  if [ -e "$1" ] && [ ! -L "$1" ]; then
    mv "$1" "$1.bak.$(date +%s)"
    echo "已备份: $1 → $1.bak.*"
  fi
}

# 1) 主启动文件
ln -sfn "$REPO_DIR/.zshrc" "$HOME/.zshrc"

# 2) 配置目录镜像（zsh / sheldon 整个目录）
mkdir -p "$CFG"
for name in zsh sheldon; do
  backup_if_real "$CFG/$name"
  ln -sfn "$REPO_DIR/.config/$name" "$CFG/$name"
done

# 3) starship 主题
backup_if_real "$CFG/starship.toml"
ln -sfn "$REPO_DIR/.config/starship.toml" "$CFG/starship.toml"

# 4) 本机私有配置模板
if [ ! -f "$REPO_DIR/.config/zsh/90-local.zsh" ]; then
  cp "$REPO_DIR/.config/zsh/90-local.zsh.example" "$REPO_DIR/.config/zsh/90-local.zsh"
  echo "已创建 90-local.zsh（来自模板），请编辑填写本机配置"
fi

echo "=================================================="
echo "安装完成。请编辑 $REPO_DIR/.config/zsh/90-local.zsh 填写本机配置，"
echo "然后新开终端或执行 exec zsh 生效。"
