# zsh-config

个人 zsh 配置：模块化、可迁移。基于 [sheldon](https://sheldon.cli.rs/) 插件管理 + [starship](https://starship.rs/) 提示符。

## 特性

- **模块化**：`~/.config/zsh/` 下按数字前缀加载（00-options → 10-paths → 20-editor → 30-completion → 40-sheldon → 50-integrations → 90-local）
- **可迁移**：PATH 与工具集成全部为存在性探测，新机器缺失的工具自动跳过，无需改配置
- **emacs 键位**：显式 `bindkey -e`（部分 zsh 构建默认 viins），Home/End/Delete/PgUp/PgDn 已绑定
- **凭据隔离**：机器相关配置（Cloudflare 凭据、代理地址）在 `90-local.zsh`，gitignore 不入库

## 目录结构

```
zsh-config/
├── .zshrc                     # 薄启动器：定义 XDG + 按序 source 模块
├── install.sh                 # 一键安装（symlink 到标准位置）
├── .gitignore                 # 忽略 90-local.zsh / plugins.lock
├── LICENSE
└── .config/
    ├── starship.toml          # starship 主题
    ├── sheldon/plugins.toml   # 插件清单
    └── zsh/
        ├── 00-options.zsh     # 历史、交互选项、缓存目录
        ├── 10-paths.zsh       # PATH（存在性探测）
        ├── 20-editor.zsh      # EDITOR、emacs 键位、功能键绑定
        ├── 30-completion.zsh  # fpath 注册
        ├── 40-sheldon.zsh     # sheldon 引导 + 静态缓存
        ├── 50-integrations.zsh# fnm / bun / cargo（条件加载）
        ├── 90-local.zsh.example # 本机私有配置模板（复制为 90-local.zsh 填写）
        └── proxy.zsh          # 代理快速启停（proxy_on/off/toggle/status）
```

## 安装（新机器）

```sh
git clone git@github.com:Traveler0014/zsh-config.git ~/zsh-config
cd ~/zsh-config && ./install.sh
# 然后编辑 ~/.config/zsh/90-local.zsh 填写本机配置
```

install.sh 会：
1. symlink `~/.zshrc` → 仓库 `.zshrc`
2. symlink `~/.config/zsh`、`~/.config/sheldon` → 仓库对应目录
3. symlink `~/.config/starship.toml` → 仓库主题
4. 从 `90-local.zsh.example` 生成 `90-local.zsh`（若不存在）

> 已有真实文件会被备份为 `*.bak.<时间戳>`。

## 依赖

| 类别 | 工具 | 缺失时 |
|---|---|---|
| 必需 | zsh ≥ 5.8、sheldon、starship | 配置不完整 |
| 推荐 | zoxide、fd、zsh-completions（sheldon 管理） | 自动跳过 |
| 可选 | fnm、bun、cargo | 自动跳过 |

## 常用操作

| 操作 | 说明 |
|---|---|
| `reload` | 干净重载配置（`exec zsh`） |
| `proxy_on` / `proxy_off` / `proxy_toggle` / `proxy_status` | 代理快速启停 |
| `Ctrl+Space` | 接受自动建议（zsh-autosuggestions） |
| `Ctrl-X Ctrl-E` | 在 `$EDITOR` 中编辑当前命令行 |
| `Home`/`End`/`Delete`/`PgUp`/`PgDn` | 均已绑定（emacs 模式） |

## 本机私有配置（90-local.zsh）

以下内容不入库（见 `.gitignore`），迁移时按新机器修改：

- `PROXY_URL` / `PROXY_SOCKS_URL`：覆盖 proxy.zsh 的中性默认值
- `CLOUDFLARE_ACCOUNT_ID` / `CLOUDFLARE_GATEWAY_ID`：Cloudflare 凭据
