# setup-mac

언어: [English](README.md) | [日本語](README.ja.md) | [Español](README.es.md) | [Português](README.pt.md) | [中文](README.zh.md) | [한국어](README.ko.md)

이 저장소는 macOS 개발 환경을 설정합니다.  
dotfiles와 Ansible을 함께 사용해 새 Mac을 빠르고 일관되게 초기 세팅할 수 있습니다.

---

## 📁 디렉터리 구조

```
setup-mac/
├── dotfiles/           # 설정 파일
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
└── ansible/            # Ansible 플레이북
    ├── site.yml
    └── roles/
        ├── homebrew/
        ├── vscode_extensions/
        ├── mise/       # mise로 툴체인 설정
        ├── macos/
        ├── dotfiles/
        └── xdg_normalize/
```

---

## 🚀 사용 방법

### 사전 요구 사항

- macOS (Apple Silicon / Intel 지원)
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

일부 작업에 관리자 권한이 필요한 경우(예: `docker` cask 설치) `--ask-become-pass`를 추가하세요:

```bash
ansible-playbook site.yml --ask-become-pass
```

Git 사용자 정보와 함께 실행하려면:

Git 사용자 이름/이메일은 다음 순서로 결정됩니다.  
1. CLI 변수 (`-e git_user_name=... -e git_user_email=...`)  
2. 환경 변수 (`GIT_USER_NAME`, `GIT_USER_EMAIL`)  
3. 여전히 없으면 실행 시 대화형 입력  

```bash
GIT_USER_NAME="Your Name" GIT_USER_EMAIL="your.email@example.com" ansible-playbook site.yml

# 또는
ansible-playbook site.yml -e git_user_name="Your Name" -e git_user_email="your.email@example.com"
```

### dotfiles 추가

1. `dotfiles/` 아래에 파일 추가
2. `ansible/custom.yml`의 `dotfiles_files_extra`에 경로 추가

> 참고: `.gitconfig`는 템플릿으로 별도 관리됩니다.

### `custom.yml`로 role 변수 커스터마이즈

`defaults/main.yml`을 수정하지 않고 `ansible/custom.yml`만으로 role 기본값을 확장할 수 있습니다.

1. `ansible/custom.yml` 수정
2. `*_extra` 변수로 항목 추가

`ansible/site.yml`은 role 실행 전에 `ansible/custom.yml`을 자동으로 불러옵니다.

예시: `ansible/custom.yml`

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

### `zsh` 설정 편집

셸 설정은 `dotfiles/.config/zsh/.zshrc`를 수정하세요.  
`dotfiles/.zshenv`에는 초기 로드되는 최소 설정(XDG 변수와 `ZDOTDIR`)이 들어 있습니다.

변경 사항을 적용하려면 새 터미널을 열거나 다음을 실행하세요:

```bash
source ~/.config/zsh/.zshrc
```

---

## 📦 주요 설치 항목

이 섹션에는 `ansible/custom.yml`(`*_extra`)로 관리되는 선택적 도구/앱/확장이 포함될 수 있습니다.

### CLI 도구 (`brew`)

| 패키지 | 설명 |
|--------|------|
| [git](https://git-scm.com/) | 버전 관리 |
| [curl](https://curl.se/) | HTTP 클라이언트 |
| [bat](https://github.com/sharkdp/bat) | 문법 하이라이트가 있는 `cat` 대체 도구 |
| [dockutil](https://github.com/kcrawford/dockutil) | Dock 항목 관리 |
| [tree](https://gitlab.com/OldManProgrammer/unix-tree) | 디렉터리 트리 뷰어 |
| [ansible](https://www.ansible.com/) | 구성 관리 |
| [eza](https://github.com/eza-community/eza) | 최신 `ls` 대체 도구 |
| [lcov](https://github.com/linux-test-project/lcov) | 커버리지 측정 도구 |
| [jq](https://jqlang.org/) | JSON 처리기 |
| [hadolint](https://github.com/hadolint/hadolint) | Dockerfile 린터 |
| [starship](https://starship.rs/) | 크로스 셸 프롬프트 |
| [mise](https://mise.jdx.dev/) | 런타임/버전 관리자 |
| [delta](https://github.com/dandavison/delta) | Git diff 뷰어 |
| [sheldon](https://github.com/rossmacarthur/sheldon) | Zsh 플러그인 매니저 |

### 애플리케이션 (`brew cask`)

| 애플리케이션 | 설명 |
|--------------|------|
| [Visual Studio Code](https://code.visualstudio.com/) | 코드 에디터 |
| [WezTerm](https://wezfurlong.org/wezterm/) | 터미널 에뮬레이터 |
| [Google Chrome](https://www.google.com/chrome/) | 웹 브라우저 |
| [Docker](https://www.docker.com/) | 컨테이너 런타임 |
| [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads) | 개발용 폰트 |
| [Android Studio](https://developer.android.com/studio) | Android IDE |

### VS Code 확장 ( `code` CLI로 설치)

| 확장 | ID |
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

### `mise`로 관리되는 툴체인

- [`ruby@latest`](https://www.ruby-lang.org/)
- [`node@lts`](https://nodejs.org/)
- [`python@latest`](https://www.python.org/)
- [`java@lts`](https://openjdk.org/)
- [`gradle@latest`](https://gradle.org/)
- [`flutter@stable`](https://flutter.dev/)

---

## 🖥️ macOS 시스템 설정

플레이북은 다음 설정을 적용합니다:

- Dock 자동 숨김 활성화
- `ansible/roles/macos/tasks/main.yml`에 정의된 앱 목록으로 Dock 항목 재구성
- Dock에서 최근 앱 숨김(고정되지 않은 앱은 종료 시 사라짐)
- Finder에서 숨김 파일 표시
- 파일 확장자 항상 표시

---

## 🧹 XDG 정규화

`xdg_normalize` role은 기본 비-XDG 경로를 XDG 호환 경로로 마이그레이션하고, 레거시 경로를 제거합니다.


**마이그레이션 목록 (기본 경로 → XDG 경로):**

| 도구 | 분류 | 기본 경로 | XDG 경로 |
|------|------|-----------|----------|
| Homebrew | 캐시 | `~/Library/Caches/Homebrew` | `~/.cache/Homebrew` |
| Ansible | 데이터 | `~/.ansible` | `~/.local/share/ansible` |
| Android SDK | 데이터 | `~/.android` | `~/.local/share/android` |
| Gradle | 데이터 | `~/.gradle` | `~/.local/share/gradle` |
| Docker | 설정 | `~/.docker` | `~/.config/docker` |
| mise | 데이터 | `~/.mise` | `~/.local/share/mise` |
| hadolint | 설정 | `~/.hadolint.yaml` | `~/.config/hadolint.yaml` |
| npm | 캐시 | `~/.npm` | `~/.cache/npm` |
| npm | 설정 | `~/.npmrc` | `~/.config/npm/npmrc` |
| Flutter/Dart (`pub`) | 캐시 | `~/.pub-cache` | `~/.cache/pub` |
| pip | 설정 | `~/.pip` | `~/.config/pip` |
| pip | 캐시 | `~/Library/Caches/pip` | `~/.cache/pip` |
| RubyGems | 캐시 | `~/.gem` | `~/.cache/gem` |
| CocoaPods | 데이터 | `~/.cocoapods` | `~/.local/share/cocoapods` |
| Claude | 설정 | `~/.claude` | `~/.config/claude` |
| GitHub Copilot | 설정 | `~/.copilot` | `~/.config/copilot` |
| less | 상태 | `~/.lesshst` | `~/.local/state/less/history` |
| Vim | 상태 | `~/.viminfo` | `~/.local/state/vim/viminfo` |
| Zsh | 설정 | `~/.zshrc`, `~/.zprofile`, `~/.zlogin`, `~/.zlogout` | `~/.config/zsh/` |
| Zsh | 히스토리 | `~/.zsh_history` | `~/.local/state/zsh/history` |
| Zsh | 세션 | `~/.zsh_sessions` | `~/.local/state/zsh/sessions` |
| Zsh | 자동완성 캐시 | `~/.zcompdump*` | `~/.config/zsh/` |

참고: 일부 도구가 XDG 경로를 지원하지 않으면 `~` 아래에 레거시 경로를 다시 만들 수 있습니다.

---

## 📄 라이선스

[MIT License](LICENSE)
