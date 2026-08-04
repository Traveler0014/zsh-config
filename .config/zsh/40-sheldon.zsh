# ------------------------------------------------------------
# 40-sheldon.zsh —— 插件管理器引导
# 管理：completions / zoxide / autosuggestions / syntax-highlighting
#       / starship / compinit（清单见 ~/.config/sheldon/plugins.toml）
#
# 静态缓存策略：sheldon 插件清单（plugins.toml / plugins.lock）有更新时，
# 重新生成静态脚本到缓存目录，之后每次启动只 source 静态文件（提速）。
# 生成采用"临时文件 + 原子替换"，避免生成失败清空缓存。
# ------------------------------------------------------------

_zsh_sheldon_init() {
  local sheldon_config="$XDG_CONFIG_HOME/sheldon/plugins.toml"
  local sheldon_lock="$XDG_CONFIG_HOME/sheldon/plugins.lock"
  local sheldon_static="$ZSH_CACHE_DIR/sheldon_static.zsh"

  # 缓存过期或缺失时重新生成（先写临时文件，成功后再替换）
  if [[ ! -f "$sheldon_static" \
        || "$sheldon_config" -nt "$sheldon_static" \
        || "$sheldon_lock"   -nt "$sheldon_static" ]]; then
    if sheldon source > "$sheldon_static.tmp" 2>/dev/null; then
      mv "$sheldon_static.tmp" "$sheldon_static"
    else
      rm -f "$sheldon_static.tmp"
    fi
  fi

  [[ -f "$sheldon_static" ]] && source "$sheldon_static"

  # zsh-autosuggestions 加载后绑定：Ctrl+Space 接受建议
  (( $+widgets[autosuggest-accept] )) && bindkey '^ ' autosuggest-accept
}

if command -v sheldon >/dev/null 2>&1; then
  _zsh_sheldon_init
fi
unset -f _zsh_sheldon_init
