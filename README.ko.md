# setup-mac

언어: [English](README.md) | [日本語](README.ja.md) | [中文](README.zh-CN.md) | [한국어](README.ko.md) | [Español](README.es.md) | [Português](README.pt-BR.md)

이 저장소는 macOS 개발 환경을 설정하기 위한 프로젝트입니다.  
dotfiles와 Ansible을 결합해 새 Mac을 빠르고 일관되게 부트스트랩할 수 있습니다.

---

## 📁 디렉터리 구조

```
setup-mac/
├── dotfiles/           # 설정 파일
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
├── ansible/            # Ansible 플레이북
│   ├── site.yml
│   └── roles/
│       ├── homebrew/
│       ├── vscode_extensions/
│       ├── mise/       # mise로 툴체인 설정
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

## 🚀 사용 방법

### 사전 요구 사항

- macOS (Apple Silicon 및 Intel 지원)
- 인터넷 연결

---

### 1. 저장소 클론

```bash
git clone https://github.com/kumo01GitHub/setup-mac.git ~/setup-mac
cd ~/setup-mac
```

---

### 2. Homebrew / Ansible 설치

Homebrew 설치:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Ansible 설치:

```bash
brew install ansible
```

### 3. Ansible 플레이북 실행

```bash
cd ~/setup-mac/ansible
ansible-playbook site.yml
```

권한 상승이 필요한 작업(예: `docker` cask 설치)이 있으면 `--ask-become-pass`를 추가하세요:

```bash
ansible-playbook site.yml --ask-become-pass
```

Git 사용자 정보로 실행하려면:

Git 사용자 이름/이메일은 다음 순서로 결정됩니다.  
1. CLI 변수 (`-e git_user_name=... -e git_user_email=...`)  
2. 환경 변수 (`GIT_USER_NAME`, `GIT_USER_EMAIL`)  
3. 여전히 없으면 실행 중 프롬프트 입력

```bash
GIT_USER_NAME="Your Name" GIT_USER_EMAIL="your.email@example.com" ansible-playbook site.yml

# 또는
ansible-playbook site.yml -e git_user_name="Your Name" -e git_user_email="your.email@example.com"
```

### dotfiles 추가

1. `dotfiles/` 아래에 파일 추가
2. `ansible/custom.yml`의 `dotfiles_files_extra`에 경로 추가

> 참고: `.gitconfig`는 템플릿으로 별도 관리됩니다.

### `custom.yml`로 롤 변수 커스터마이즈

`defaults/main.yml`을 직접 수정하지 않고 `ansible/custom.yml`만으로 기본값을 확장할 수 있습니다.

1. `ansible/custom.yml` 편집
2. `*_extra` 변수로 항목 추가

`ansible/site.yml`은 롤 실행 전에 `ansible/custom.yml`을 자동 로드합니다.

예시: `ansible/custom.yml`

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

### `zsh` 설정 편집

셸 커스터마이즈는 `dotfiles/.config/zsh/.zshrc`를 수정하세요.  
`dotfiles/.zshenv`에는 최소한의 초기 로드 설정(XDG 변수 및 `ZDOTDIR`)이 들어 있습니다.

변경 적용은 새 터미널을 열거나 다음을 실행하세요:

```bash
source ~/.config/zsh/.zshrc
```

---

## 📦 주요 설치 항목

이 섹션의 항목에는 `ansible/custom.yml`의 `*_extra`로 관리되는 선택 도구/앱/확장도 포함될 수 있습니다.

### CLI 도구 (`brew`)

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

### 애플리케이션 (`brew cask`)

| Application | Description |
|-------------|-------------|
| [Visual Studio Code](https://code.visualstudio.com/) | Code editor |
| [WezTerm](https://wezfurlong.org/wezterm/) | Terminal emulator |
| [Google Chrome](https://www.google.com/chrome/) | Web browser |
| [Docker](https://www.docker.com/) | Container runtime |
| [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads) | Development font |
| [Android Studio](https://developer.android.com/studio) | Android IDE |

### VS Code 확장 (`code` CLI로 설치)

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

### `mise`로 관리하는 툴체인

- [`ruby@latest`](https://www.ruby-lang.org/)
- [`node@latest`](https://nodejs.org/)
- [`python@latest`](https://www.python.org/)
- [`java@latest`](https://openjdk.org/)
- [`gradle@latest`](https://gradle.org/)
- [`flutter@latest`](https://flutter.dev/)

---

## 🖥️ macOS 시스템 설정

플레이북은 다음 설정을 적용합니다.

- Dock 자동 숨김 활성화
- `ansible/roles/macos/tasks/main.yml`에 정의된 앱 목록으로 Dock 재구성
- Dock 최근 앱 숨김(고정되지 않은 앱은 종료 시 사라짐)
- Finder에서 숨김 파일 표시
- 파일 확장자 항상 표시

---

## 🧹 XDG 정규화

`xdg_normalize` 롤은 기본 비XDG 경로를 XDG 준수 경로로 마이그레이션하고 레거시 경로를 제거합니다.


**마이그레이션 목록(기본 경로 → XDG 경로):**

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

## 📄 라이선스

[MIT License](LICENSE)
