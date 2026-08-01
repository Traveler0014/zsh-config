# ------------------------------------------------------------
# 30-completion.zsh —— 补全
# compinit 由 sheldon 的 compinit 插件负责（见 40-sheldon.zsh）
# 本模块仅注册自定义补全/函数目录
# ------------------------------------------------------------

for _zsh_f in "$XDG_CONFIG_HOME/zsh/functions" "$HOME/.zfunc"; do
  [[ -d "$_zsh_f" ]] && fpath=("$_zsh_f" $fpath)
done
unset _zsh_f
