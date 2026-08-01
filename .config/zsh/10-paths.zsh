# ------------------------------------------------------------
# 10-paths.zsh —— PATH 管理
# 全部为存在性探测：目录不存在则跳过，可安全迁移到新机器
# 列表顺序 = 优先级顺序（越靠前优先级越高）
# ------------------------------------------------------------

typeset -U path    # 去重，保证重复 source 幂等

typeset -a _zsh_paths=(
  "$HOME/.local/bin"              # pipx / uv / 本地脚本
  "$HOME/.cargo/bin"              # Rust 工具链
  "$HOME/.bun/bin"                # Bun
  "$HOME/.local/go/bin"           # 本地 Go
  "$HOME/go/bin"                  # Go 全局二进制
  "$HOME/.local/share/pnpm/bin"   # pnpm
)

for _zsh_p in $_zsh_paths; do
  [[ -d "$_zsh_p" ]] && path=( "$_zsh_p" $path )
done
unset _zsh_p _zsh_paths

# pnpm（保留原语义：PNPM_HOME 指向目录本身）
if [[ -d "$HOME/.local/share/pnpm" ]]; then
  export PNPM_HOME="$HOME/.local/share/pnpm"
fi

# 某些安装脚本会生成 ~/.local/bin/env 兜底文件（若存在则加载）
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
