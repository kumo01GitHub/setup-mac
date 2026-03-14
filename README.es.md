# setup-mac

Idiomas: [English](README.md) | [日本語](README.ja.md) | [Español](README.es.md) | [Português](README.pt.md) | [中文](README.zh.md) | [한국어](README.ko.md)

Este repositorio configura un entorno de desarrollo en macOS.  
Combina dotfiles y Ansible para que puedas preparar un Mac nuevo de forma rápida y consistente.

---

## 📁 Estructura de directorios

```
setup-mac/
├── dotfiles/           # Archivos de configuración
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
└── ansible/            # Playbooks de Ansible
    ├── site.yml
    └── roles/
        ├── homebrew/
        ├── vscode_extensions/
        ├── mise/       # Configuración de toolchains con mise
        ├── macos/
        ├── dotfiles/
        └── xdg_normalize/
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

Si una tarea requiere privilegios elevados (por ejemplo, instalar el cask `docker`), incluye `--ask-become-pass`:

```bash
ansible-playbook site.yml --ask-become-pass
```

Para ejecutar con valores de identidad de Git:

El nombre y correo de Git se resuelven en este orden:  
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
2. Agrega rutas a `ansible/custom.yml` usando `dotfiles_files_extra`

> Nota: `.gitconfig` se gestiona por separado mediante plantilla.

### Personalizar variables de rol con `custom.yml`

Puedes agregar elementos a los valores por defecto de los roles sin editar `defaults/main.yml`, usando solo `ansible/custom.yml`.

1. Edita `ansible/custom.yml`
2. Agrega elementos usando variables `*_extra`

`ansible/site.yml` carga automáticamente `ansible/custom.yml` antes de ejecutar los roles.

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

### Editar la configuración de `zsh`

Edita `dotfiles/.config/zsh/.zshrc` para personalizar el shell.  
`dotfiles/.zshenv` contiene la configuración mínima que se carga al inicio (variables XDG y `ZDOTDIR`).

Para aplicar cambios, abre una terminal nueva o ejecuta:

```bash
source ~/.config/zsh/.zshrc
```

---

## 📦 Elementos principales instalados

Los elementos de esta sección pueden incluir herramientas, aplicaciones o extensiones opcionales gestionadas mediante `ansible/custom.yml` (`*_extra`).

### Herramientas CLI (`brew`)

| Paquete | Descripción |
|---------|-------------|
| [git](https://git-scm.com/) | Control de versiones |
| [curl](https://curl.se/) | Cliente HTTP |
| [bat](https://github.com/sharkdp/bat) | Alternativa a `cat` con resaltado de sintaxis |
| [dockutil](https://github.com/kcrawford/dockutil) | Gestión de elementos del Dock |
| [tree](https://gitlab.com/OldManProgrammer/unix-tree) | Visualizador de árbol de directorios |
| [ansible](https://www.ansible.com/) | Gestión de configuración |
| [eza](https://github.com/eza-community/eza) | Alternativa moderna a `ls` |
| [lcov](https://github.com/linux-test-project/lcov) | Herramienta de medición de cobertura |
| [jq](https://jqlang.org/) | Procesador de JSON |
| [hadolint](https://github.com/hadolint/hadolint) | Linter para Dockerfile |
| [starship](https://starship.rs/) | Prompt multiplataforma para shells |
| [mise](https://mise.jdx.dev/) | Gestor de versiones/runtimes |
| [delta](https://github.com/dandavison/delta) | Visor de diferencias para Git |
| [sheldon](https://github.com/rossmacarthur/sheldon) | Gestor de plugins de Zsh |

### Aplicaciones (`brew cask`)

| Aplicación | Descripción |
|------------|-------------|
| [Visual Studio Code](https://code.visualstudio.com/) | Editor de código |
| [WezTerm](https://wezfurlong.org/wezterm/) | Emulador de terminal |
| [Google Chrome](https://www.google.com/chrome/) | Navegador web |
| [Docker](https://www.docker.com/) | Runtime de contenedores |
| [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads) | Fuente para desarrollo |
| [Android Studio](https://developer.android.com/studio) | IDE de Android |

### Extensiones de VS Code (instaladas mediante CLI `code`)

| Extensión | ID |
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
- [`node@lts`](https://nodejs.org/)
- [`python@latest`](https://www.python.org/)
- [`java@lts`](https://openjdk.org/)
- [`gradle@latest`](https://gradle.org/)
- [`flutter@stable`](https://flutter.dev/)

---

## 🖥️ Preferencias del sistema macOS

El playbook aplica las siguientes configuraciones:

- Activar ocultación automática del Dock
- Reconstruir elementos del Dock desde la lista de aplicaciones definida en `ansible/roles/macos/tasks/main.yml`
- Ocultar aplicaciones recientes en el Dock (las aplicaciones no fijadas desaparecen al cerrarse)
- Mostrar archivos ocultos en Finder
- Mostrar siempre las extensiones de archivo

---

## 🧹 Normalización XDG

El rol `xdg_normalize` migra rutas predeterminadas no compatibles con XDG a ubicaciones compatibles con XDG y elimina rutas heredadas.


**Lista de migración (ruta predeterminada → ruta XDG):**

| Herramienta | Categoría | Ruta predeterminada | Ruta XDG |
|-------------|-----------|---------------------|----------|
| Homebrew | Caché | `~/Library/Caches/Homebrew` | `~/.cache/Homebrew` |
| Ansible | Datos | `~/.ansible` | `~/.local/share/ansible` |
| Android SDK | Datos | `~/.android` | `~/.local/share/android` |
| Gradle | Datos | `~/.gradle` | `~/.local/share/gradle` |
| Docker | Configuración | `~/.docker` | `~/.config/docker` |
| mise | Datos | `~/.mise` | `~/.local/share/mise` |
| hadolint | Configuración | `~/.hadolint.yaml` | `~/.config/hadolint.yaml` |
| npm | Caché | `~/.npm` | `~/.cache/npm` |
| npm | Configuración | `~/.npmrc` | `~/.config/npm/npmrc` |
| Flutter/Dart (`pub`) | Caché | `~/.pub-cache` | `~/.cache/pub` |
| pip | Configuración | `~/.pip` | `~/.config/pip` |
| pip | Caché | `~/Library/Caches/pip` | `~/.cache/pip` |
| RubyGems | Caché | `~/.gem` | `~/.cache/gem` |
| CocoaPods | Datos | `~/.cocoapods` | `~/.local/share/cocoapods` |
| Claude | Configuración | `~/.claude` | `~/.config/claude` |
| GitHub Copilot | Configuración | `~/.copilot` | `~/.config/copilot` |
| less | Estado | `~/.lesshst` | `~/.local/state/less/history` |
| Vim | Estado | `~/.viminfo` | `~/.local/state/vim/viminfo` |
| Zsh | Configuración | `~/.zshrc`, `~/.zprofile`, `~/.zlogin`, `~/.zlogout` | `~/.config/zsh/` |
| Zsh | Historial | `~/.zsh_history` | `~/.local/state/zsh/history` |
| Zsh | Sesiones | `~/.zsh_sessions` | `~/.local/state/zsh/sessions` |
| Zsh | Caché de completado | `~/.zcompdump*` | `~/.config/zsh/` |

Nota: Algunas herramientas pueden volver a crear rutas heredadas en `~` si no admiten rutas XDG.

---

## 📄 Licencia

[MIT License](LICENSE)
