# ============================================================
# Zsh 配置入口（薄启动器）
# 管理仓库：git@github.com:Traveler0014/zsh-config.git
# 所有配置模块位于 $XDG_CONFIG_HOME/zsh/（默认 ~/.config/zsh）
#
# 迁移到新环境：
#   1. git clone git@github.com:Traveler0014/zsh-config.git ~/zsh-config
#   2. cd ~/zsh-config && ./install.sh   （自动 symlink 到标准位置）
#   3. 按新机器情况修改 90-local.zsh（机器相关凭据/变量）
#   4. 其余模块全部为存在性探测：缺失的工具/目录会被自动跳过
# ============================================================

# ---- XDG 基础目录（在任何模块使用之前定义） ----
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# ---- 加载配置模块（数字前缀决定加载顺序） ----
typeset -a zsh_modules
zsh_modules=("$XDG_CONFIG_HOME"/zsh/[0-9][0-9]-*.zsh(N))
for _zsh_module in $zsh_modules; do
  source "$_zsh_module"
done
unset _zsh_module zsh_modules

# ---- 可插拔可选插件（删除文件即禁用） ----
[[ -f "$XDG_CONFIG_HOME/zsh/proxy.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/proxy.zsh"
