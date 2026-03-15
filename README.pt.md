# setup-mac

Idiomas: [English](README.md) | [日本語](README.ja.md) | [Español](README.es.md) | [Português](README.pt.md) | [中文](README.zh.md) | [한국어](README.ko.md)

Este repositório configura um ambiente de desenvolvimento no macOS.  
Ele combina dotfiles e Ansible para que você possa preparar um novo Mac de forma rápida e consistente.

---

## 📁 Estrutura de diretórios

```
setup-mac/
├── dotfiles/           # Arquivos de configuração
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
└── ansible/            # Playbooks do Ansible
    ├── site.yml
    └── roles/
        ├── homebrew/
        ├── vscode_extensions/
        ├── mise/       # Configuração de toolchains com mise
        ├── macos/
        ├── dotfiles/
        └── xdg_normalize/
```

---

## 🚀 Uso

### Pré-requisitos

- macOS (Apple Silicon e Intel compatíveis)
- Conexão com a Internet

---

### 1. Clonar o repositório

```bash
git clone https://github.com/kumo01GitHub/setup-mac.git ~/setup-mac
cd ~/setup-mac
```

---

### 2. Instalar Homebrew / Ansible

Instalar o Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Instalar o Ansible:

```bash
brew install ansible
```

### 3. Executar o playbook do Ansible

```bash
cd ~/setup-mac/ansible
ansible-playbook site.yml
```

Se uma tarefa exigir privilégios elevados (por exemplo, instalar o cask `docker`), inclua `--ask-become-pass`:

```bash
ansible-playbook site.yml --ask-become-pass
```

Para executar com valores de identidade do Git:

Nome e e-mail do Git são resolvidos nesta ordem:  
1. Variáveis de CLI (`-e git_user_name=... -e git_user_email=...`)  
2. Variáveis de ambiente (`GIT_USER_NAME`, `GIT_USER_EMAIL`)  
3. Prompt interativo em tempo de execução, se ainda estiver faltando  

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

`ansible/site.yml` carrega automaticamente `ansible/custom.yml` antes da execução das roles.

Exemplo: `ansible/custom.yml`

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

### Editar configuração do `zsh`

Edite `dotfiles/.config/zsh/.zshrc` para personalizar o shell.  
`dotfiles/.zshenv` contém as configurações mínimas carregadas no início (variáveis XDG e `ZDOTDIR`).

Para aplicar alterações, abra um novo terminal ou execute:

```bash
source ~/.config/zsh/.zshrc
```

---

## 📦 Principais itens instalados

Os itens desta seção podem incluir ferramentas, apps e extensões opcionais gerenciados por `ansible/custom.yml` (`*_extra`).

### Ferramentas CLI (`brew`)

| Pacote | Descrição |
|--------|-----------|
| [git](https://git-scm.com/) | Controle de versão |
| [curl](https://curl.se/) | Cliente HTTP |
| [bat](https://github.com/sharkdp/bat) | Alternativa ao `cat` com destaque de sintaxe |
| [dockutil](https://github.com/kcrawford/dockutil) | Gerenciamento de itens do Dock |
| [tree](https://gitlab.com/OldManProgrammer/unix-tree) | Visualizador de árvore de diretórios |
| [ansible](https://www.ansible.com/) | Gerenciamento de configuração |
| [eza](https://github.com/eza-community/eza) | Alternativa moderna ao `ls` |
| [lcov](https://github.com/linux-test-project/lcov) | Ferramenta de medição de cobertura |
| [jq](https://jqlang.org/) | Processador JSON |
| [hadolint](https://github.com/hadolint/hadolint) | Linter de Dockerfile |
| [starship](https://starship.rs/) | Prompt multiplataforma para shell |
| [mise](https://mise.jdx.dev/) | Gerenciador de versões/runtimes |
| [delta](https://github.com/dandavison/delta) | Visualizador de diff para Git |
| [sheldon](https://github.com/rossmacarthur/sheldon) | Gerenciador de plugins do Zsh |

### Aplicativos (`brew cask`)

| Aplicativo | Descrição |
|------------|-----------|
| [Visual Studio Code](https://code.visualstudio.com/) | Editor de código |
| [WezTerm](https://wezfurlong.org/wezterm/) | Emulador de terminal |
| [Google Chrome](https://www.google.com/chrome/) | Navegador web |
| [Docker](https://www.docker.com/) | Runtime de contêineres |
| [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads) | Fonte para desenvolvimento |
| [Android Studio](https://developer.android.com/studio) | IDE Android |

### Extensões do VS Code (instaladas via CLI `code`)

| Extensão | ID |
|----------|----|
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
- [`node@lts`](https://nodejs.org/)
- [`python@latest`](https://www.python.org/)
- [`java@lts`](https://openjdk.org/)
- [`gradle@latest`](https://gradle.org/)
- [`flutter@stable`](https://flutter.dev/)

---

## 🖥️ Preferências do sistema macOS

O playbook aplica as seguintes configurações:

- Ativar ocultação automática do Dock
- Reconstruir itens do Dock a partir da lista de apps definida em `ansible/roles/macos/tasks/main.yml`
- Ocultar apps recentes no Dock (apps não fixados desaparecem ao fechar)
- Mostrar arquivos ocultos no Finder
- Sempre mostrar extensões de arquivo

---

## 🧹 Normalização XDG

A role `xdg_normalize` migra caminhos padrão não compatíveis com XDG para locais compatíveis com XDG e remove caminhos legados.


**Lista de migração (caminho padrão → caminho XDG):**

| Ferramenta | Categoria | Caminho padrão | Caminho XDG |
|------------|-----------|----------------|-------------|
| Homebrew | Cache | `~/Library/Caches/Homebrew` | `~/.cache/Homebrew` |
| Ansible | Dados | `~/.ansible` | `~/.local/share/ansible` |
| Android SDK | Dados | `~/.android` | `~/.local/share/android` |
| Gradle | Dados | `~/.gradle` | `~/.local/share/gradle` |
| Docker | Configuração | `~/.docker` | `~/.config/docker` |
| mise | Dados | `~/.mise` | `~/.local/share/mise` |
| hadolint | Configuração | `~/.hadolint.yaml` | `~/.config/hadolint.yaml` |
| npm | Cache | `~/.npm` | `~/.cache/npm` |
| npm | Configuração | `~/.npmrc` | `~/.config/npm/npmrc` |
| Flutter/Dart (`pub`) | Cache | `~/.pub-cache` | `~/.cache/pub` |
| pip | Configuração | `~/.pip` | `~/.config/pip` |
| pip | Cache | `~/Library/Caches/pip` | `~/.cache/pip` |
| RubyGems | Cache | `~/.gem` | `~/.cache/gem` |
| CocoaPods | Dados | `~/.cocoapods` | `~/.local/share/cocoapods` |
| Claude | Configuração | `~/.claude` | `~/.config/claude` |
| GitHub Copilot | Configuração | `~/.copilot` | `~/.config/copilot` |
| less | Estado | `~/.lesshst` | `~/.local/state/less/history` |
| Vim | Estado | `~/.viminfo` | `~/.local/state/vim/viminfo` |
| Zsh | Configuração | `~/.zshrc`, `~/.zprofile`, `~/.zlogin`, `~/.zlogout` | `~/.config/zsh/` |
| Zsh | Histórico | `~/.zsh_history` | `~/.local/state/zsh/history` |
| Zsh | Sessões | `~/.zsh_sessions` | `~/.local/state/zsh/sessions` |
| Zsh | Cache de conclusão | `~/.zcompdump*` | `~/.config/zsh/` |

Nota: Algumas ferramentas podem recriar caminhos legados em `~` se não oferecerem suporte a caminhos XDG.

---

## 📄 Licença

[MIT License](LICENSE)
