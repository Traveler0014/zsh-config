# ------------------------------------------------------------
# 50-integrations.zsh —— 运行时与工具集成（cargo / fnm / bun）
# 策略：逐项存在性探测，工具未安装则静默跳过（新环境缺失工具不影响启动）
# ------------------------------------------------------------

# Rust 工具链（非交互 shell 由 ~/.zshenv 加载，这里补交互场景的重新加载）
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# fnm（Node.js 版本管理；--use-on-cd 进入含 .node-version/.nvmrc 的目录自动切换）
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# Bun
export BUN_INSTALL="$HOME/.bun"
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"   # bun 补全
