# setup-mac

[![CI](https://github.com/kumo01GitHub/setup-mac/actions/workflows/ci.yml/badge.svg)](https://github.com/kumo01GitHub/setup-mac/actions/workflows/ci.yml) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Languages: [English](README.md) | [日本語](README.ja.md) | [Español](README.es.md) | [Português](README.pt.md) | [中文](README.zh.md) | [한국어](README.ko.md)

This repository sets up a macOS development environment.  
It combines dotfiles and Ansible so you can bootstrap a new Mac quickly and consistently.

---

## 📁 Directory Structure

```
setup-mac/
├── dotfiles/           # Configuration files
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
└── ansible/            # Ansible playbooks
    ├── site.yml
    └── roles/
        ├── homebrew/
        ├── vscode_extensions/
        ├── mise/       # Toolchain setup via mise
        ├── macos/
        ├── dotfiles/
        └── xdg_normalize/
```

---

## 🚀 Usage

### Prerequisites

- macOS (Apple Silicon and Intel supported)
- Internet connection

---

### 1. Clone the repository

```bash
git clone https://github.com/kumo01GitHub/setup-mac.git ~/setup-mac
cd ~/setup-mac
```

---

### 2. Install Homebrew / Ansible

Install Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install Ansible:

```bash
brew install ansible
```

### 3. Run the Ansible playbook

```bash
cd ~/setup-mac/ansible
ansible-playbook site.yml
```

If a task requires elevated privileges (for example, installing the `docker` cask), include `--ask-become-pass`:

```bash
ansible-playbook site.yml --ask-become-pass
```

To run with Git identity values:

Git user name/email are resolved in this order:  
1. CLI vars (`-e git_user_name=... -e git_user_email=...`)  
2. Environment variables (`GIT_USER_NAME`, `GIT_USER_EMAIL`)  
3. Interactive prompt at runtime when still missing  

```bash
GIT_USER_NAME="Your Name" GIT_USER_EMAIL="your.email@example.com" ansible-playbook site.yml

# or
ansible-playbook site.yml -e git_user_name="Your Name" -e git_user_email="your.email@example.com"
```

### Add dotfiles

1. Add files under `dotfiles/`
2. Add paths to `ansible/custom.yml` using `dotfiles_files_extra`

> Note: `.gitconfig` is managed separately via template.

### Customize role variables with `custom.yml`

You can add items to role defaults without editing `defaults/main.yml`, using only `ansible/custom.yml`.

1. Edit `ansible/custom.yml`
2. Add items using `*_extra` variables

`ansible/site.yml` automatically loads `ansible/custom.yml` before roles run.

Example: `ansible/custom.yml`

```yaml
homebrew_packages_extra:

homebrew_cask_apps_extra:
    - firefox

mise_plugins_extra:
    - java

mise_toolchains_extra:
    - go@latest

dotfiles_files_extra:
    - .config/mytool/config.toml
```

### Edit `zsh` configuration

Edit `dotfiles/.config/zsh/.zshrc` for shell customization.  
`dotfiles/.zshenv` contains the minimal, early-loaded settings (XDG variables and `ZDOTDIR`).

To apply changes, open a new terminal or run:

```bash
source ~/.config/zsh/.zshrc
```

---

## 📦 Main Installed Items

Items in this section can include optional tools/apps/extensions managed via `ansible/custom.yml` (`*_extra`).

### CLI tools (`brew`)

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

### Applications (`brew cask`)

| Application | Description |
|-------------|-------------|
| [Visual Studio Code](https://code.visualstudio.com/) | Code editor |
| [WezTerm](https://wezfurlong.org/wezterm/) | Terminal emulator |
| [Google Chrome](https://www.google.com/chrome/) | Web browser |
| [Docker](https://www.docker.com/) | Container runtime |
| [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads) | Development font |
| [Android Studio](https://developer.android.com/studio) | Android IDE |

### VS Code extensions (installed via `code` CLI)

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

### Toolchains managed by `mise`

- [`ruby@latest`](https://www.ruby-lang.org/)
- [`node@lts`](https://nodejs.org/)
- [`python@latest`](https://www.python.org/)
- [`java@lts`](https://openjdk.org/)
- [`gradle@latest`](https://gradle.org/)
- [`flutter@stable`](https://flutter.dev/)

---

## 🖥️ macOS System Preferences

The playbook applies the following settings:

- Enable Dock auto-hide
- Rebuild Dock items from the app list defined in `ansible/roles/macos/tasks/main.yml`
- Hide recent apps in Dock (non-pinned apps disappear when closed)
- Show hidden files in Finder
- Always show file extensions

---

## 🧹 XDG Normalization

The `xdg_normalize` role migrates default non-XDG paths into XDG-compliant locations and removes legacy paths.


**Migration list (default path → XDG path):**

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
| Claude | Config | `~/.claude` | `~/.config/claude` |
| GitHub Copilot | Config | `~/.copilot` | `~/.config/copilot` |
| less | State | `~/.lesshst` | `~/.local/state/less/history` |
| Vim | State | `~/.viminfo` | `~/.local/state/vim/viminfo` |
| Zsh | Config | `~/.zshrc`, `~/.zprofile`, `~/.zlogin`, `~/.zlogout` | `~/.config/zsh/` |
| Zsh | History | `~/.zsh_history` | `~/.local/state/zsh/history` |
| Zsh | Sessions | `~/.zsh_sessions` | `~/.local/state/zsh/sessions` |
| Zsh | Completion cache | `~/.zcompdump*` | `~/.config/zsh/` |

Note: Some tools may recreate legacy paths under `~` if they do not support XDG paths.

---

## 📄 License

[MIT License](LICENSE)
