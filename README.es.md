# setup-mac

Idiomas: [English](README.md) | [日本語](README.ja.md) | [中文](README.zh-CN.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Português](README.pt-BR.md)

Este repositorio configura un entorno de desarrollo en macOS.  
Combina dotfiles y Ansible para que puedas preparar un Mac nuevo de forma rápida y consistente.

---

## 📁 Estructura de directorios

```
setup-mac/
├── dotfiles/           # Archivos de configuración
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
├── ansible/            # Playbooks de Ansible
│   ├── site.yml
│   └── roles/
│       ├── homebrew/
│       ├── vscode_extensions/
│       ├── mise/       # Configuración de toolchain con mise
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

### Requisitos previos

- macOS (compatible con Apple Silicon e Intel)
- Conexión a Internet

---

### 1. Clonar el repositorio

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

### 3. Ejecutar el playbook de Ansible

```bash
cd ~/setup-mac/ansible
ansible-playbook site.yml
```

Si una tarea requiere privilegios elevados (por ejemplo, instalar el cask `docker`), añade `--ask-become-pass`:

```bash
ansible-playbook site.yml --ask-become-pass
```

Para ejecutar con identidad de Git:

El nombre/correo de Git se resuelve en este orden:  
1. Variables CLI (`-e git_user_name=... -e git_user_email=...`)  
2. Variables de entorno (`GIT_USER_NAME`, `GIT_USER_EMAIL`)  
3. Solicitud interactiva en tiempo de ejecución si aún faltan

```bash
GIT_USER_NAME="Your Name" GIT_USER_EMAIL="your.email@example.com" ansible-playbook site.yml

# o
ansible-playbook site.yml -e git_user_name="Your Name" -e git_user_email="your.email@example.com"
```

### Agregar dotfiles

1. Agrega archivos en `dotfiles/`
2. Agrega rutas en `ansible/custom.yml` usando `dotfiles_files_extra`

> Nota: `.gitconfig` se gestiona por separado mediante plantilla.

### Personalizar variables de rol con `custom.yml`

Puedes añadir elementos a los valores por defecto de los roles sin editar `defaults/main.yml`, usando solo `ansible/custom.yml`.

1. Edita `ansible/custom.yml`
2. Agrega elementos con variables `*_extra`

`ansible/site.yml` carga automáticamente `ansible/custom.yml` antes de ejecutar roles.

Ejemplo: `ansible/custom.yml`

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

### Editar configuración de `zsh`

Edita `dotfiles/.config/zsh/.zshrc` para personalizar el shell.  
`dotfiles/.zshenv` contiene la configuración mínima de carga temprana (variables XDG y `ZDOTDIR`).

Para aplicar cambios, abre una terminal nueva o ejecuta:

```bash
source ~/.config/zsh/.zshrc
```

---

## 📦 Elementos principales instalados

Los elementos de esta sección pueden incluir herramientas/apps/extensiones opcionales administradas vía `ansible/custom.yml` (`*_extra`).

### Herramientas CLI (`brew`)

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

### Aplicaciones (`brew cask`)

| Application | Description |
|-------------|-------------|
| [Visual Studio Code](https://code.visualstudio.com/) | Code editor |
| [WezTerm](https://wezfurlong.org/wezterm/) | Terminal emulator |
| [Google Chrome](https://www.google.com/chrome/) | Web browser |
| [Docker](https://www.docker.com/) | Container runtime |
| [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads) | Development font |
| [Android Studio](https://developer.android.com/studio) | Android IDE |

### Extensiones de VS Code (instaladas con `code` CLI)

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

### Toolchains gestionados por `mise`

- [`ruby@latest`](https://www.ruby-lang.org/)
- [`node@latest`](https://nodejs.org/)
- [`python@latest`](https://www.python.org/)
- [`java@latest`](https://openjdk.org/)
- [`gradle@latest`](https://gradle.org/)
- [`flutter@latest`](https://flutter.dev/)

---

## 🖥️ Preferencias del sistema macOS

El playbook aplica estas configuraciones:

- Habilita el auto-ocultado del Dock
- Reconstruye los elementos del Dock desde la lista de apps definida en `ansible/roles/macos/tasks/main.yml`
- Oculta apps recientes en el Dock (apps no fijadas desaparecen al cerrarse)
- Muestra archivos ocultos en Finder
- Muestra siempre las extensiones de archivo

---

## 🧹 Normalización XDG

El rol `xdg_normalize` migra rutas predeterminadas no compatibles con XDG a ubicaciones compatibles y elimina rutas heredadas.


**Lista de migración (ruta predeterminada → ruta XDG):**

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

## 📄 Licencia

[MIT License](LICENSE)
