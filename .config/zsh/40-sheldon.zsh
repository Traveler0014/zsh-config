# ------------------------------------------------------------
# 40-sheldon.zsh —— 插件管理器引导
# 管理：completions / zoxide / autosuggestions / syntax-highlighting
#       / starship / compinit
#
# 静态缓存策略：配置或锁文件有更新时自动重新生成
# ------------------------------------------------------------

_zsh_sheldon_init() {
  local sheldon_config="$XDG_CONFIG_HOME/sheldon/plugins.toml"
  local sheldon_lock="$XDG_CONFIG_HOME/sheldon/plugins.lock"
  local sheldon_static="$ZSH_CACHE_DIR/sheldon_static.zsh"

  # 缓存过期或缺失时重新生成
  if [[ ! -f "$sheldon_static" \
        || "$sheldon_config" -nt "$sheldon_static" \
        || "$sheldon_lock"   -nt "$sheldon_static" ]]; then
    sheldon source > "$sheldon_static" 2>/dev/null
  fi

  [[ -f "$sheldon_static" ]] && source "$sheldon_static"

  # zsh-autosuggestions 加载后绑定：Ctrl+Space 接受建议
  (( $+widgets[autosuggest-accept] )) && bindkey '^ ' autosuggest-accept
}

if command -v sheldon >/dev/null 2>&1; then
  _zsh_sheldon_init
fi
unset -f _zsh_sheldon_init
