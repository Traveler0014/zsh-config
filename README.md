# zsh-config

个人 zsh 配置：模块化、可迁移。基于 [sheldon](https://sheldon.cli.rs/) 插件管理 + [starship](https://starship.rs/) 提示符。

## 特性

- **模块化**：`~/.config/zsh/` 下按数字前缀加载（00-options → 10-paths → 20-editor → 30-completion → 40-sheldon → 50-integrations → 90-local），文件缺失自动跳过
- **可迁移**：PATH 与工具集成全部为存在性探测，新机器缺失的工具自动跳过，无需改配置
- **凭据隔离**：机器相关配置（Cloudflare 凭据、API token）在 `90-local.zsh` / `secrets.zsh`，均 gitignore 不入库
- **原子缓存**：sheldon 静态缓存采用"临时文件 + mv 替换"，生成失败不会清空缓存
- **emacs 键位**：显式 `bindkey -e`，Home/End/Delete/PgUp/PgDn 显式绑定
- **非交互可用**：`.zshenv` 加载 cargo，cron/脚本中也能用 cargo/uv

## 目录结构

```
zsh-config/
├── .zshrc                     # 薄启动器：定义 XDG + 按序 source 模块
├── .zshenv                    # 非交互 shell 环境（cargo / 用户级 bin）
├── install.sh                 # 一键安装（symlink 到标准位置）
├── .gitignore                 # 忽略 90-local.zsh / secrets.zsh / plugins.lock
├── LICENSE
└── .config/
    ├── starship.toml          # starship 主题（含 vimcmd 符号）
    ├── sheldon/plugins.toml   # 插件清单（含 zoxide 存在性守卫）
    └── zsh/
        ├── 00-options.zsh     # 历史（XDG）、交互选项、缓存目录
        ├── 10-paths.zsh       # PATH（存在性探测 + 去重）
        ├── 20-editor.zsh      # EDITOR、emacs 键位、功能键绑定
        ├── 30-completion.zsh  # fpath 注册
        ├── 40-sheldon.zsh     # sheldon 引导 + 静态缓存（原子写入）
        ├── 50-integrations.zsh# fnm / bun / cargo（条件加载）
        ├── 90-local.zsh       # 本机私有配置（凭据等，不入库）
        ├── 90-local.zsh.example # 模板（install.sh 据此生成）
        ├── secrets.zsh        # 私密环境变量（权限 600，不入库）
        └── proxy.zsh          # 代理快速启停（proxy_on/off/toggle/status）
```

## 安装（新机器）

```sh
git clone git@github.com:Traveler0014/zsh-config.git ~/zsh-config
cd ~/zsh-config && ./install.sh
# 然后编辑 ~/zsh-config/.config/zsh/90-local.zsh 填写本机配置
```

install.sh 会：
1. symlink `~/.zshrc`、`~/.zshenv` → 仓库对应文件
2. symlink `~/.config/zsh`、`~/.config/sheldon` → 仓库对应目录
3. symlink `~/.config/starship.toml` → 仓库主题
4. 从 `90-local.zsh.example` 生成 `90-local.zsh`（若不存在）
5. 迁移原有 `secrets.zsh`（若存在）到仓库目录并置为 600（不入库）

> 已有真实文件会被备份为 `*.bak.<时间戳>`。

## 依赖

| 类别 | 工具 | 缺失时 |
|---|---|---|
| 必需 | zsh ≥ 5.8、sheldon、starship | 配置不完整 |
| 推荐 | zoxide、fd、zsh-completions（sheldon 管理） | 自动跳过 |
| 可选 | fnm、bun、cargo | 自动跳过 |

> conda 默认不随 shell 加载（可显著加快启动）；需要时在目标机器运行 `conda init zsh` 启用。

## 常用操作

| 操作 | 说明 |
|---|---|
| `reload` | 干净重载配置（`exec zsh`） |
| `proxy_on` / `proxy_off` / `proxy_toggle` / `proxy_status` | 代理快速启停 |
| `Ctrl+Space` | 接受自动建议（zsh-autosuggestions） |
| `Ctrl-X Ctrl-E` | 在 `$EDITOR` 中编辑当前命令行 |
| `Home`/`End`/`Delete`/`PgUp`/`PgDn` | 均已绑定 |

## 本机私有配置（90-local.zsh / secrets.zsh）

以下内容不入库（见 `.gitignore`），迁移时按新机器修改：

- `CLOUDFLARE_ACCOUNT_ID` / `CLOUDFLARE_GATEWAY_ID`：Cloudflare 凭据
- `PROXY_URL` / `PROXY_SOCKS_URL`：覆盖 proxy.zsh 的中性默认值
- `secrets.zsh`：其他 API token（权限 600）

## 新增自定义函数/初始化模块

需要本机专属的函数或初始化（如环境激活、自定义命令）时，在 `~/.config/zsh/` 下新建
`60-local-apps.zsh`（数字前缀决定加载顺序），格式与其它模块一致；删除文件即禁用。
