# zmodload zsh/zprof

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=4000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

# 遵循 XDG 标准定义路径
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# 手动创建属于 Zsh 的缓存目录逻辑
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"

# 逻辑防御：确保目录真实存在，否则重定向将失败
[[ ! -d "$ZSH_CACHE_DIR" ]] && mkdir -p "$ZSH_CACHE_DIR"

# autoload -Uz compinit
# compinit
# End of lines added by compinstall

alias vim=nvim
export EDITOR=nvim

. "$HOME/.cargo/env"
fpath+=~/.zfunc

eval "$(starship init zsh)"

# # 逻辑检查：仅在 sheldon 命令存在时加载
# if command -v sheldon &> /dev/null; then
#   eval "$(sheldon source)"
# fi

# Sheldon 静态编译逻辑
local SHELDON_CONFIG="$XDG_CONFIG_HOME/sheldon/plugins.toml"
local SHELDON_LOCK="$XDG_CONFIG_HOME/sheldon/plugins.lock"
local SHELDON_STATIC="$ZSH_CACHE_DIR/sheldon_static.zsh"

# 判别准则：若配置或锁文件比静态脚本新，则重新生成
if [[ ! -f "$SHELDON_STATIC" || "$SHELDON_CONFIG" -nt "$SHELDON_STATIC" || "$SHELDON_LOCK" -nt "$SHELDON_STATIC" ]]; then
  # 提示：仅在后台静默生成
  sheldon source > "$SHELDON_STATIC" 2>/dev/null
fi

# 最终加载
source "$SHELDON_STATIC"
