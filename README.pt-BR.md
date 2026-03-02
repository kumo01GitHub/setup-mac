# setup-mac

Idiomas: [English](README.md) | [日本語](README.ja.md) | [中文](README.zh-CN.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Português](README.pt-BR.md)

Este repositório configura um ambiente de desenvolvimento macOS.  
Ele combina dotfiles e Ansible para que você possa preparar um novo Mac de forma rápida e consistente.

---

## 📁 Estrutura de diretórios

```
setup-mac/
├── dotfiles/           # Arquivos de configuração
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
├── ansible/            # Playbooks Ansible
│   ├── site.yml
│   └── roles/
│       ├── homebrew/
│       ├── vscode_extensions/
│       ├── mise/       # Configuração de toolchain via mise
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

## 🚀 Uso

### Pré-requisitos

- macOS (suporte para Apple Silicon e Intel)
- Conexão com a internet

---

### 1. Clonar o repositório

```bash
git clone https://github.com/kumo01GitHub/setup-mac.git ~/setup-mac
cd ~/setup-mac
```

---

### 2. Instalar Homebrew / Ansible

Instalar Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Instalar Ansible:

```bash
brew install ansible
```

### 3. Executar o playbook Ansible

```bash
cd ~/setup-mac/ansible
ansible-playbook site.yml
```

Se alguma tarefa exigir privilégios elevados (por exemplo, instalar o cask `docker`), inclua `--ask-become-pass`:

```bash
ansible-playbook site.yml --ask-become-pass
```

Para executar com identidade Git:

Nome/e-mail do Git são resolvidos nesta ordem:  
1. Variáveis CLI (`-e git_user_name=... -e git_user_email=...`)  
2. Variáveis de ambiente (`GIT_USER_NAME`, `GIT_USER_EMAIL`)  
3. Prompt interativo em tempo de execução, se ainda estiver ausente

```bash
GIT_USER_NAME="Your Name" GIT_USER_EMAIL="your.email@example.com" ansible-playbook site.yml

# ou
ansible-playbook site.yml -e git_user_name="Your Name" -e git_user_email="your.email@example.com"
```

### Adicionar dotfiles

1. Adicione arquivos em `dotfiles/`
2. Adicione caminhos em `ansible/custom.yml` usando `dotfiles_files_extra`

> Observação: `.gitconfig` é gerenciado separadamente por template.

### Personalizar variáveis de role com `custom.yml`

Você pode adicionar itens aos padrões das roles sem editar `defaults/main.yml`, usando apenas `ansible/custom.yml`.

1. Edite `ansible/custom.yml`
2. Adicione itens usando variáveis `*_extra`

`ansible/site.yml` carrega automaticamente `ansible/custom.yml` antes de executar as roles.

Exemplo: `ansible/custom.yml`

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

### Editar configuração do `zsh`

Edite `dotfiles/.config/zsh/.zshrc` para personalizar o shell.  
`dotfiles/.zshenv` contém as configurações mínimas carregadas cedo (variáveis XDG e `ZDOTDIR`).

Para aplicar alterações, abra um novo terminal ou execute:

```bash
source ~/.config/zsh/.zshrc
```

---

## 📦 Principais itens instalados

Os itens desta seção podem incluir ferramentas/apps/extensões opcionais gerenciadas por `ansible/custom.yml` (`*_extra`).

### Ferramentas CLI (`brew`)

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

### Aplicações (`brew cask`)

| Application | Description |
|-------------|-------------|
| [Visual Studio Code](https://code.visualstudio.com/) | Code editor |
| [WezTerm](https://wezfurlong.org/wezterm/) | Terminal emulator |
| [Google Chrome](https://www.google.com/chrome/) | Web browser |
| [Docker](https://www.docker.com/) | Container runtime |
| [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads) | Development font |
| [Android Studio](https://developer.android.com/studio) | Android IDE |

### Extensões do VS Code (instaladas via `code` CLI)

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

### Toolchains gerenciados por `mise`

- [`ruby@latest`](https://www.ruby-lang.org/)
- [`node@latest`](https://nodejs.org/)
- [`python@latest`](https://www.python.org/)
- [`java@latest`](https://openjdk.org/)
- [`gradle@latest`](https://gradle.org/)
- [`flutter@latest`](https://flutter.dev/)

---

## 🖥️ Preferências do sistema macOS

O playbook aplica as seguintes configurações:

- Ativar auto-ocultação do Dock
- Reconstruir itens do Dock a partir da lista de apps definida em `ansible/roles/macos/tasks/main.yml`
- Ocultar apps recentes no Dock (apps não fixados desaparecem ao fechar)
- Mostrar arquivos ocultos no Finder
- Sempre mostrar extensões de arquivo

---

## 🧹 Normalização XDG

A role `xdg_normalize` migra caminhos padrão não XDG para locais compatíveis com XDG e remove caminhos legados.


**Lista de migração (caminho padrão → caminho XDG):**

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

## 📄 Licença

[MIT License](LICENSE)
