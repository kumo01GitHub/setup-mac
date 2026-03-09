# setup-mac

语言: [English](README.md) | [日本語](README.ja.md) | [Español](README.es.md) | [Português](README.pt.md) | [中文](README.zh.md) | [한국어](README.ko.md)

这个仓库用于搭建 macOS 开发环境。  
它结合了 dotfiles 和 Ansible，帮助你快速且一致地初始化一台新的 Mac。

---

## 📁 目录结构

```
setup-mac/
├── dotfiles/           # 配置文件
│   ├── .zshenv
│   ├── .gitconfig
│   └── .config/
│       ├── zsh/
│       │   └── .zshrc
│       ├── git/
│       │   └── config
│       ├── sheldon/
│       │   └── plugins.toml
│       ├── wezterm/
│       │   └── wezterm.lua
│       └── starship.toml
└── ansible/            # Ansible 剧本
    ├── site.yml
    └── roles/
        ├── homebrew/
        ├── vscode_extensions/
        ├── mise/       # 使用 mise 配置工具链
        ├── macos/
        ├── dotfiles/
        └── xdg_normalize/
```

---

## 🚀 使用方法

### 前置条件

- macOS（支持 Apple Silicon 和 Intel）
- 网络连接

---

### 1. 克隆仓库

```bash
git clone https://github.com/kumo01GitHub/setup-mac.git ~/setup-mac
cd ~/setup-mac
```

---

### 2. 安装 Homebrew / Ansible

安装 Homebrew：

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

安装 Ansible：

```bash
brew install ansible
```

### 3. 运行 Ansible Playbook

```bash
cd ~/setup-mac/ansible
ansible-playbook site.yml
```

如果某些任务需要提权（例如安装 `docker` cask），请添加 `--ask-become-pass`：

```bash
ansible-playbook site.yml --ask-become-pass
```

如需带 Git 身份信息运行：

Git 用户名/邮箱按以下顺序解析：  
1. CLI 变量（`-e git_user_name=... -e git_user_email=...`）  
2. 环境变量（`GIT_USER_NAME`, `GIT_USER_EMAIL`）  
3. 若仍缺失，则在运行时交互输入  

```bash
GIT_USER_NAME="Your Name" GIT_USER_EMAIL="your.email@example.com" ansible-playbook site.yml

# 或
ansible-playbook site.yml -e git_user_name="Your Name" -e git_user_email="your.email@example.com"
```

### 添加 dotfiles

1. 在 `dotfiles/` 下添加文件
2. 在 `ansible/custom.yml` 中通过 `dotfiles_files_extra` 添加路径

> 注意：`.gitconfig` 通过模板单独管理。

### 使用 `custom.yml` 自定义角色变量

你可以只编辑 `ansible/custom.yml`，通过追加方式扩展角色默认值，而无需修改 `defaults/main.yml`。

1. 编辑 `ansible/custom.yml`
2. 使用 `*_extra` 变量添加项目

`ansible/site.yml` 会在角色执行前自动加载 `ansible/custom.yml`。

示例：`ansible/custom.yml`

```yaml
homebrew_packages_extra:
    - ripgrep

homebrew_cask_apps_extra:
    - firefox

mise_plugins_extra:
    - java

mise_toolchains_extra:
    - go@latest

dotfiles_files_extra:
    - .config/mytool/config.toml
```

### 编辑 `zsh` 配置

请编辑 `dotfiles/.config/zsh/.zshrc` 进行 shell 自定义。  
`dotfiles/.zshenv` 保存最小且最早加载的配置（XDG 变量与 `ZDOTDIR`）。

应用改动时，打开一个新终端或执行：

```bash
source ~/.config/zsh/.zshrc
```

---

## 📦 主要安装内容

本节可能包含通过 `ansible/custom.yml`（`*_extra`）管理的可选工具、应用和扩展。

### CLI 工具（`brew`）

| 软件包 | 说明 |
|--------|------|
| [git](https://git-scm.com/) | 版本控制 |
| [curl](https://curl.se/) | HTTP 客户端 |
| [bat](https://github.com/sharkdp/bat) | 带语法高亮的 `cat` 替代 |
| [dockutil](https://github.com/kcrawford/dockutil) | Dock 项管理 |
| [tree](https://gitlab.com/OldManProgrammer/unix-tree) | 目录树查看器 |
| [ansible](https://www.ansible.com/) | 配置管理 |
| [eza](https://github.com/eza-community/eza) | 现代化 `ls` 替代 |
| [lcov](https://github.com/linux-test-project/lcov) | 覆盖率统计工具 |
| [jq](https://jqlang.org/) | JSON 处理器 |
| [hadolint](https://github.com/hadolint/hadolint) | Dockerfile Linter |
| [starship](https://starship.rs/) | 跨 shell 提示符 |
| [mise](https://mise.jdx.dev/) | 运行时/版本管理器 |
| [delta](https://github.com/dandavison/delta) | Git diff 查看器 |
| [sheldon](https://github.com/rossmacarthur/sheldon) | Zsh 插件管理器 |

### 应用（`brew cask`）

| 应用 | 说明 |
|------|------|
| [Visual Studio Code](https://code.visualstudio.com/) | 代码编辑器 |
| [WezTerm](https://wezfurlong.org/wezterm/) | 终端模拟器 |
| [Google Chrome](https://www.google.com/chrome/) | Web 浏览器 |
| [Docker](https://www.docker.com/) | 容器运行时 |
| [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads) | 开发字体 |
| [Android Studio](https://developer.android.com/studio) | Android IDE |

### VS Code 扩展（通过 `code` CLI 安装）

| 扩展 | ID |
|------|----|
| EditorConfig | `EditorConfig.EditorConfig` |
| indent-rainbow | `oderwat.indent-rainbow` |
| Prettier | `esbenp.prettier-vscode` |
| ESLint | `dbaeumer.vscode-eslint` |
| Python | `ms-python.python` |
| Pylance | `ms-python.vscode-pylance` |
| Dart | `Dart-Code.dart-code` |
| Flutter | `Dart-Code.flutter` |
| Kotlin | `fwcd.kotlin` |
| Swift | `swiftlang.swift-vscode` |
| Java Extension Pack | `vscjava.vscode-java-pack` |
| Gradle for Java | `vscjava.vscode-gradle` |
| Spring Boot Tools | `vmware.vscode-spring-boot` |
| YAML | `redhat.vscode-yaml` |
| XML | `redhat.vscode-xml` |

### 由 `mise` 管理的工具链

- [`ruby@latest`](https://www.ruby-lang.org/)
- [`node@latest`](https://nodejs.org/)
- [`python@latest`](https://www.python.org/)
- [`java@latest`](https://openjdk.org/)
- [`gradle@latest`](https://gradle.org/)
- [`flutter@latest`](https://flutter.dev/)

---

## 🖥️ macOS 系统偏好设置

Playbook 会应用以下设置：

- 启用 Dock 自动隐藏
- 根据 `ansible/roles/macos/tasks/main.yml` 定义的应用列表重建 Dock 项
- 在 Dock 中隐藏最近使用的应用（未固定应用在关闭后消失）
- 在 Finder 中显示隐藏文件
- 始终显示文件扩展名

---

## 🧹 XDG 规范化

`xdg_normalize` 角色会将默认的非 XDG 路径迁移到符合 XDG 的位置，并删除旧路径。


**迁移列表（默认路径 → XDG 路径）：**

| 工具 | 类别 | 默认路径 | XDG 路径 |
|------|------|----------|----------|
| Homebrew | 缓存 | `~/Library/Caches/Homebrew` | `~/.cache/Homebrew` |
| Ansible | 数据 | `~/.ansible` | `~/.local/share/ansible` |
| Android SDK | 数据 | `~/.android` | `~/.local/share/android` |
| Gradle | 数据 | `~/.gradle` | `~/.local/share/gradle` |
| Docker | 配置 | `~/.docker` | `~/.config/docker` |
| mise | 数据 | `~/.mise` | `~/.local/share/mise` |
| hadolint | 配置 | `~/.hadolint.yaml` | `~/.config/hadolint.yaml` |
| npm | 缓存 | `~/.npm` | `~/.cache/npm` |
| npm | 配置 | `~/.npmrc` | `~/.config/npm/npmrc` |
| Flutter/Dart (`pub`) | 缓存 | `~/.pub-cache` | `~/.cache/pub` |
| pip | 配置 | `~/.pip` | `~/.config/pip` |
| pip | 缓存 | `~/Library/Caches/pip` | `~/.cache/pip` |
| RubyGems | 缓存 | `~/.gem` | `~/.cache/gem` |
| CocoaPods | 数据 | `~/.cocoapods` | `~/.local/share/cocoapods` |
| less | 状态 | `~/.lesshst` | `~/.local/state/less/history` |
| Vim | 状态 | `~/.viminfo` | `~/.local/state/vim/viminfo` |
| Zsh | 配置 | `~/.zshrc`, `~/.zprofile`, `~/.zlogin`, `~/.zlogout` | `~/.config/zsh/` |
| Zsh | 历史 | `~/.zsh_history` | `~/.local/state/zsh/history` |
| Zsh | 会话 | `~/.zsh_sessions` | `~/.local/state/zsh/sessions` |
| Zsh | 补全缓存 | `~/.zcompdump*` | `~/.config/zsh/` |

---

## 📄 许可证

[MIT License](LICENSE)
