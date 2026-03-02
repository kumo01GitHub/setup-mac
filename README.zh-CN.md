# setup-mac

语言: [English](README.md) | [日本語](README.ja.md) | [中文](README.zh-CN.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Português](README.pt-BR.md)

此仓库用于搭建 macOS 开发环境。  
它将 dotfiles 与 Ansible 结合，让你可以快速且一致地初始化一台新 Mac。

---

## 📁 目录结构

```
setup-mac/
├── dotfiles/           # 配置文件
│   ├── .zshenv
│   ├── .gitconfig
│   ├── .config/
│   │   ├── zsh/
│   │   │   └── .zshrc
│   │   ├── git/
│   │   │   └── config
│   │   ├── sheldon/
│   │   │   └── plugins.toml
│   │   ├── wezterm/
│   │   │   └── wezterm.lua
│   │   └── starship.toml
├── ansible/            # Ansible playbook
│   ├── site.yml
│   └── roles/
│       ├── homebrew/
│       ├── vscode_extensions/
│       ├── mise/       # 使用 mise 配置工具链
│       ├── macos/
│       ├── dotfiles/
│       └── xdg_normalize/
├── README.md
├── README.ja.md
├── README.zh-CN.md
├── README.ko.md
├── README.es.md
└── README.pt-BR.md
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

### 3. 运行 Ansible playbook

```bash
cd ~/setup-mac/ansible
ansible-playbook site.yml
```

如果某些任务需要提升权限（例如安装 `docker` cask），请加上 `--ask-become-pass`：

```bash
ansible-playbook site.yml --ask-become-pass
```

如果要带 Git 身份信息执行：

Git 用户名/邮箱按以下顺序解析：  
1. CLI 变量（`-e git_user_name=... -e git_user_email=...`）  
2. 环境变量（`GIT_USER_NAME`, `GIT_USER_EMAIL`）  
3. 仍缺失时在运行期间交互输入

```bash
GIT_USER_NAME="Your Name" GIT_USER_EMAIL="your.email@example.com" ansible-playbook site.yml

# 或
ansible-playbook site.yml -e git_user_name="Your Name" -e git_user_email="your.email@example.com"
```

### 添加 dotfiles

1. 将文件添加到 `dotfiles/`
2. 在 `ansible/custom.yml` 的 `dotfiles_files_extra` 中添加路径

> 注意：`.gitconfig` 通过模板单独管理。

### 使用 `custom.yml` 自定义角色变量

无需修改 `defaults/main.yml`，你可以只通过 `ansible/custom.yml` 追加默认项。

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

通过编辑 `dotfiles/.config/zsh/.zshrc` 来自定义 shell。  
`dotfiles/.zshenv` 包含最小且最早加载的配置（XDG 变量与 `ZDOTDIR`）。

应用变更时，打开新终端或运行：

```bash
source ~/.config/zsh/.zshrc
```

---

## 📦 主要安装项

本节中的项目可包含通过 `ansible/custom.yml`（`*_extra`）管理的可选工具/应用/扩展。

### CLI 工具（`brew`）

| Package | Description |
|---------|-------------|
| [git](https://git-scm.com/) | Version control |
| [curl](https://curl.se/) | HTTP client |
| [bat](https://github.com/sharkdp/bat) | `cat` alternative with syntax highlighting |
| [dockutil](https://github.com/kcrawford/dockutil) | Dock item management |
| [tree](https://gitlab.com/OldManProgrammer/unix-tree) | Directory tree viewer |
| [ansible](https://www.ansible.com/) | Configuration management |
| [eza](https://github.com/eza-community/eza) | Modern `ls` alternative |
| [lcov](https://github.com/linux-test-project/lcov) | Coverage measurement tool |
| [jq](https://jqlang.org/) | JSON processor |
| [hadolint](https://github.com/hadolint/hadolint) | Dockerfile linter |
| [starship](https://starship.rs/) | Cross-shell prompt |
| [mise](https://mise.jdx.dev/) | Runtime/version manager |
| [delta](https://github.com/dandavison/delta) | Git diff viewer |
| [sheldon](https://github.com/rossmacarthur/sheldon) | Zsh plugin manager |

### 应用（`brew cask`）

| Application | Description |
|-------------|-------------|
| [Visual Studio Code](https://code.visualstudio.com/) | Code editor |
| [WezTerm](https://wezfurlong.org/wezterm/) | Terminal emulator |
| [Google Chrome](https://www.google.com/chrome/) | Web browser |
| [Docker](https://www.docker.com/) | Container runtime |
| [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads) | Development font |
| [Android Studio](https://developer.android.com/studio) | Android IDE |

### VS Code 扩展（通过 `code` CLI 安装）

| Extension | ID |
|-----------|----|
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

playbook 会应用以下设置：

- 启用 Dock 自动隐藏
- 按 `ansible/roles/macos/tasks/main.yml` 中定义的应用列表重建 Dock 项
- 在 Dock 中隐藏最近使用的应用（未固定应用关闭后会消失）
- 在 Finder 中显示隐藏文件
- 始终显示文件扩展名

---

## 🧹 XDG 规范化

`xdg_normalize` 角色会将默认的非 XDG 路径迁移到符合 XDG 的路径，并删除旧路径。


**迁移列表（默认路径 → XDG 路径）：**

| Tool | Category | Default path | XDG path |
|------|----------|--------------|----------|
| Homebrew | Cache | `~/Library/Caches/Homebrew` | `~/.cache/Homebrew` |
| Ansible | Data | `~/.ansible` | `~/.local/share/ansible` |
| Android SDK | Data | `~/.android` | `~/.local/share/android` |
| Gradle | Data | `~/.gradle` | `~/.local/share/gradle` |
| Docker | Config | `~/.docker` | `~/.config/docker` |
| mise | Data | `~/.mise` | `~/.local/share/mise` |
| hadolint | Config | `~/.hadolint.yaml` | `~/.config/hadolint.yaml` |
| npm | Cache | `~/.npm` | `~/.cache/npm` |
| npm | Config | `~/.npmrc` | `~/.config/npm/npmrc` |
| Flutter/Dart (`pub`) | Cache | `~/.pub-cache` | `~/.cache/pub` |
| pip | Config | `~/.pip` | `~/.config/pip` |
| pip | Cache | `~/Library/Caches/pip` | `~/.cache/pip` |
| RubyGems | Cache | `~/.gem` | `~/.cache/gem` |
| CocoaPods | Data | `~/.cocoapods` | `~/.local/share/cocoapods` |
| less | State | `~/.lesshst` | `~/.local/state/less/history` |
| Vim | State | `~/.viminfo` | `~/.local/state/vim/viminfo` |
| Zsh | Config | `~/.zshrc`, `~/.zprofile`, `~/.zlogin`, `~/.zlogout` | `~/.config/zsh/` |
| Zsh | History | `~/.zsh_history` | `~/.local/state/zsh/history` |
| Zsh | Sessions | `~/.zsh_sessions` | `~/.local/state/zsh/sessions` |
| Zsh | Completion cache | `~/.zcompdump*` | `~/.config/zsh/` |

---

## 📄 许可证

[MIT License](LICENSE)
