# ------------------------------------------------------------
# 50-integrations.zsh —— 运行时与工具集成
# 全部为存在性探测：工具未安装则静默跳过（可安全迁移）
# ------------------------------------------------------------

# Rust 工具链
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# fnm（Node.js 版本管理）
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# Bun 补全
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"
