# ------------------------------------------------------------
# 00-options.zsh —— 基础选项与历史记录
# ------------------------------------------------------------

# ---- 历史记录（数据存放于 $XDG_DATA_HOME，随配置一起迁移） ----
export HISTFILE="$XDG_DATA_HOME/zsh/history"
export HISTSIZE=10000
export SAVEHIST=10000

setopt EXTENDED_HISTORY          # 记录时间戳
setopt HIST_IGNORE_ALL_DUPS      # 不记录重复命令
setopt HIST_SAVE_NO_DUPS         # 不保存重复历史
setopt HIST_REDUCE_BLANKS        # 去除多余空白
setopt HIST_IGNORE_SPACE         # 以空格开头的命令不记入历史
setopt SHARE_HISTORY             # 多终端共享历史
setopt INC_APPEND_HISTORY        # 实时追加历史（而非等退出）
setopt HIST_FCNTL_LOCK           # 用 fcntl 锁历史文件（多终端更可靠）

# ---- 缓存 / 数据目录 ----
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
export ZSH_DATA_DIR="$XDG_DATA_HOME/zsh"
[[ ! -d "$ZSH_CACHE_DIR" ]] && mkdir -p "$ZSH_CACHE_DIR"
[[ ! -d "$ZSH_DATA_DIR" ]] && mkdir -p "$ZSH_DATA_DIR"

# ---- 交互选项 ----
setopt NO_BEEP                   # 静音
setopt AUTO_CD                   # 目录名即 cd
setopt CD_SILENT                 # cd 不输出路径
setopt EXTENDED_GLOB             # 扩展通配符
