# ============================================================
# Zsh 配置入口（薄启动器）
# 管理仓库：git@github.com:Traveler0014/zsh-config.git
# 所有配置模块位于 $XDG_CONFIG_HOME/zsh/（默认 ~/.config/zsh）
#
# 维护说明：
#   - 新增/移除模块：在 $XDG_CONFIG_HOME/zsh/ 下新建或删除 NN-name.zsh，
#     数字前缀决定加载顺序（00 最先、90 最后），文件缺失自动跳过
#   - 迁移/新环境：git clone 本仓库 → ./install.sh → 按需填写 90-local.zsh；
#     其余模块均为存在性探测，缺失的工具/目录自动忽略
#
# 模块加载顺序（数字前缀）：
#   00-options → 10-paths → 20-editor → 30-completion → 40-sheldon
#   → 50-integrations → 90-local → proxy.zsh(可插拔)
# ============================================================

# zmodload zsh/zprof   # 启动性能分析（取消注释后 `zprof` 查看）

# ---- XDG 基础目录（在任何模块使用之前定义） ----
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

# ---- 加载配置模块（数字前缀决定加载顺序，缺失文件自动跳过） ----
typeset -a zsh_modules
zsh_modules=("$XDG_CONFIG_HOME"/zsh/[0-9][0-9]-*.zsh(N))
for _zsh_module in $zsh_modules; do
  source "$_zsh_module"
done
unset _zsh_module zsh_modules

# ---- 可插拔可选插件（删除文件即禁用） ----
[[ -f "$XDG_CONFIG_HOME/zsh/proxy.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/proxy.zsh"
