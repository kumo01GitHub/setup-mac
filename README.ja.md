# setup-mac

言語: [English](README.md) | [日本語](README.ja.md)

Macの環境をセットアップするためのリポジトリです。  
dotfiles（設定ファイル群）と Ansible を組み合わせて、新しい Mac をすばやく自分好みに整えることができます。

---

## 📁 ディレクトリ構成

```
setup-mac/
├── dotfiles/           # 設定ファイル群
│   ├── .zshenv         # Zshの早期設定（XDGとZDOTDIR）
│   ├── .gitconfig      # Gitの設定
│   ├── .config/
│   │   ├── zsh/
│   │   │   └── .zshrc  # Zshの設定
│   │   ├── git/
│   │   │   └── config  # GitのXDG設定
│   │   ├── sheldon/
│   │   │   └── plugins.toml # Zshプラグイン設定
│   │   ├── wezterm/
│   │   │   └── wezterm.lua # WezTermの設定
│   │   └── starship.toml # Starshipの設定
├── ansible/            # Ansible プレイブック
│   ├── site.yml        # メインプレイブック
│   └── roles/
│       ├── homebrew/   # Homebrew・パッケージインストール
│       ├── vscode_extensions/ # VS Code拡張機能のインストール
│       ├── mise/       # miseでツールチェーンをセットアップ
│       ├── macos/      # macOSシステム設定
│       ├── dotfiles/   # dotfilesの上書きコピー設定
│       └── xdg_normalize/ # XDG非準拠ディレクトリの正規化
├── README.md
└── README.ja.md
```

---

## 🚀 使い方

### 前提条件

- macOS（Apple Silicon / Intel どちらも対応）
- インターネット接続

---

### 1. リポジトリのクローン

```bash
git clone https://github.com/kumo01GitHub/setup-mac.git ~/setup-mac
cd ~/setup-mac
```

---

### 2. Homebrew / Ansible のインストール

Homebrew のインストール:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Ansible のインストール:

```bash
brew install ansible
```

### 3. プレイブックを実行

```bash
cd ~/setup-mac/ansible
ansible-playbook site.yml
```

管理者権限が必要なタスクがある場合（例: `docker` の cask インストール）は、`--ask-become-pass` を付けて実行してください:

```bash
ansible-playbook site.yml --ask-become-pass
```

---

## ⚙️ カスタマイズ

### インストールするパッケージを変更する

`ansible/roles/homebrew/defaults/main.yml` を編集して、`homebrew_packages` にインストールしたいパッケージを追加・削除してください。

例（このファイルを編集してください）:

```yaml
# ansible/roles/homebrew/defaults/main.yml
homebrew_packages:
  - git
  - curl
  # ここに追加したいパッケージを記載
```

### mise のツールチェーンとプラグインを変更する

`ansible/roles/mise/defaults/main.yml` を編集して `mise_plugins` と `mise_toolchains` を変更してください。

```yaml
# ansible/roles/mise/defaults/main.yml
mise_plugins:
  - flutter

mise_toolchains:
  - ruby@latest
  - node@latest
  # 必要に応じて追加・削除してください
```

### dotfiles を追加する

1. `dotfiles/` ディレクトリに設定ファイルを追加する
2. `ansible/roles/dotfiles/tasks/main.yml` の `loop` にファイル名を追加する

### `zsh` の設定を編集する

シェル設定は `dotfiles/.config/zsh/.zshrc` を編集してください。  
`dotfiles/.zshenv` は Zsh 起動前に読み込まれる最小設定（XDG 変数と `ZDOTDIR` の設定）です。

変更を反映するには、新しいターミナルを開くか以下を実行します。

```bash
source ~/.config/zsh/.zshrc
```

### Gitの設定を変更する

`dotfiles/.gitconfig` の `[user]` セクションを自分の名前とメールアドレスに変更してください。  
Git の詳細設定は `dotfiles/.config/git/config` を編集してください。

```ini
[user]
    name = Your Name
    email = your.email@example.com
```

---

## 📦 インストールされる主なもの

### CLIツール（brew）

| パッケージ | 説明 |
|-----------|------|
| [git](https://git-scm.com/) | バージョン管理 |
| [curl](https://curl.se/) | HTTP クライアント |
| [bat](https://github.com/sharkdp/bat) | `cat` 代替（シンタックスハイライト付き） |
| [dockutil](https://github.com/kcrawford/dockutil) | Dock項目管理 |
| [tree](https://gitlab.com/OldManProgrammer/unix-tree) | ディレクトリ表示 |
| [ansible](https://www.ansible.com/) | 構成管理ツール |
| [eza](https://github.com/eza-community/eza) | 高機能 `ls` 代替 |
| [lcov](https://github.com/linux-test-project/lcov) | カバレッジ計測ツール |
| [jq](https://jqlang.org/) | JSONプロセッサ |
| [docker-compose](https://docs.docker.com/compose/) | コンテナオーケストレーション |
| [hadolint](https://github.com/hadolint/hadolint) | Dockerfileリンター |
| [starship](https://starship.rs/) | クロスシェルプロンプト |
| [mise](https://mise.jdx.dev/) | 開発ツールバージョン管理 |
| [delta](https://github.com/dandavison/delta) | 差分ビューア |
| [sheldon](https://github.com/rossmacarthur/sheldon) | Zshプラグインマネージャー |

### アプリケーション（brew cask）

| アプリ | 説明 |
|--------|------|
| [Visual Studio Code](https://code.visualstudio.com/) | コードエディタ |
| [WezTerm](https://wezfurlong.org/wezterm/) | ターミナルエミュレータ |
| [Google Chrome](https://www.google.com/chrome/) | ウェブブラウザ |
| [Docker](https://www.docker.com/) | コンテナ実行環境 |
| [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads) | 開発用フォント |
| [Android Studio](https://developer.android.com/studio) | Android IDE |

### VS Code拡張機能（`code` CLIでインストール）

| 拡張機能 | ID |
|---------|----|
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

### mise で管理するツールチェーン

- [`ruby@latest`](https://www.ruby-lang.org/)
- [`node@latest`](https://nodejs.org/)
- [`python@latest`](https://www.python.org/)
- [`java@latest`](https://openjdk.org/)
- [`gradle@latest`](https://gradle.org/)
- [`flutter@latest`](https://flutter.dev/)

---

## 🖥️ macOS システム設定

Ansible 実行時に以下の設定が適用されます。

- Dock の自動非表示を有効化
- Dock に表示するアプリを指定リストで再構成（`ansible/roles/macos/tasks/main.yml` 内で定義）
- 最近使ったアプリを Dock に表示しない（未固定アプリは終了時に消える）
- Finder で隠しファイルを表示
- ファイル拡張子を常に表示

---

## 🧹 XDG 正規化

プレイブック実行時に `xdg_normalize` ロールで、デフォルトの非XDGパスをXDG配下へ移設し、レガシーパスは削除します。

Ansibleの一時ファイルは、`.zshenv`で設定される環境変数により`~/.cache/ansible/tmp`に作成されます。プレイブック実行後、旧来の`~/.ansible`ディレクトリは自動的に削除されます。

**移設一覧（デフォルトパス → XDGパス）：**

| ツール | 分類 | デフォルトパス | XDGパス |
|--------|------|----------------|----------|
| Homebrew | キャッシュ | `~/Library/Caches/Homebrew` | `~/.cache/Homebrew` |
| Ansible | データ | `~/.ansible` | `~/.local/share/ansible` |
| Android SDK | データ | `~/.android` | `~/.local/share/android` |
| Gradle | データ | `~/.gradle` | `~/.local/share/gradle` |
| Docker | 設定 | `~/.docker` | `~/.config/docker` |
| mise | データ | `~/.mise` | `~/.local/share/mise` |
| hadolint | 設定 | `~/.hadolint.yaml` | `~/.config/hadolint.yaml` |
| npm | キャッシュ | `~/.npm` | `~/.cache/npm` |
| npm | 設定 | `~/.npmrc` | `~/.config/npm/npmrc` |
| Flutter/Dart（pub） | キャッシュ | `~/.pub-cache` | `~/.cache/pub` |
| pip | 設定 | `~/.pip` | `~/.config/pip` |
| pip | キャッシュ | `~/Library/Caches/pip` | `~/.cache/pip` |
| RubyGems | キャッシュ | `~/.gem` | `~/.cache/gem` |
| CocoaPods | データ | `~/.cocoapods` | `~/.local/share/cocoapods` |
| Zsh | 設定 | `~/.zshrc`, `~/.zprofile`, `~/.zlogin`, `~/.zlogout` | `~/.config/zsh/` |
| Zsh | 履歴 | `~/.zsh_history` | `~/.local/state/zsh/history` |
| Zsh | セッション | `~/.zsh_sessions` | `~/.local/state/zsh/sessions` |
| Zsh | 補完キャッシュ | `~/.zcompdump*` | `~/.config/zsh/` |

---

## 📄 ライセンス

[MIT License](LICENSE)
