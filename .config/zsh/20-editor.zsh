# ------------------------------------------------------------
# 20-editor.zsh —— 编辑器与键位
# 显式启用 Emacs 风格键位（不再使用 vi 模式）
# 注意：部分 zsh 构建（含本机 5.9）默认 main→viins，
#       必须显式 bindkey -e 才能保证跨环境行为一致
# ------------------------------------------------------------

export EDITOR=nvim
export VISUAL="$EDITOR"
alias vim=nvim

# 显式启用 emacs 键位（覆盖编译默认值）
bindkey -e

# ---- 终端功能键（Home/End/Delete/PgUp/PgDn）----
# zsh 默认键位表未绑定这些序列（均为 undefined-key），需显式绑定。
# 绑定多个变体以兼容不同终端/终端模式，未用到的序列不会产生副作用。
bindkey '^[[H'  beginning-of-line        # Home（xterm/大多数现代终端）
bindkey '^[[F'  end-of-line              # End
bindkey '^[OH'  beginning-of-line        # Home（应用光标模式/tmux）
bindkey '^[OF'  end-of-line              # End
bindkey '^[[1~' beginning-of-line        # Home（linux console/screen）
bindkey '^[[4~' end-of-line              # End
bindkey '^[[7~' beginning-of-line        # Home（老终端）
bindkey '^[[8~' end-of-line              # End
bindkey '^[[3~' delete-char              # Delete
bindkey '^[[2~' overwrite-mode           # Insert
bindkey '^[[5~' beginning-of-history     # PageUp
bindkey '^[[6~' end-of-history           # PageDown
bindkey '^X^E'  edit-command-line        # Ctrl-X Ctrl-E：在 $EDITOR 中编辑命令行

# ---- 辅助别名 ----
alias reload='exec zsh'    # 干净地重载配置（exec 不残留旧变量）
