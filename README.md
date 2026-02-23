# setup-mac

Macの環境をセットアップするためのリポジトリです。  
dotfiles（設定ファイル群）と Ansible を組み合わせて、新しい Mac をすばやく自分好みに整えることができます。

---

## 📁 ディレクトリ構成

```
setup-mac/
├── dotfiles/           # 設定ファイル群
│   ├── .zshrc          # Zshの設定
│   ├── .gitconfig      # Gitの設定
│   ├── .config/
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
│       ├── macos/      # macOSシステム設定
│       └── dotfiles/   # dotfilesのシンボリックリンク設定
└── README.md
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

### 2. Ansible で全自動セットアップする場合

Ansible を使うと以下の作業をまとめて自動化できます。

- Homebrew のインストール
- 開発ツール・アプリのインストール（`brew` / `brew cask`）
- macOS システム設定の変更
- dotfiles のシンボリックリンク作成

#### 2-1. Ansible のインストール

```bash
# Homebrewをインストール（未インストールの場合）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Ansibleをインストール
brew install ansible
```

#### 2-2. プレイブックの実行

```bash
cd ~/setup-mac/ansible
ansible-playbook site.yml
```

パスワードが求められる場合は `--ask-become-pass` オプションを追加してください。

```bash
ansible-playbook site.yml --ask-become-pass
```

---

## ⚙️ カスタマイズ

### インストールするパッケージを変更する

`ansible/roles/homebrew/tasks/main.yml` を編集して、インストールしたいパッケージを追加・削除してください。

```yaml
- name: brewパッケージをインストール
  homebrew:
    name: "{{ item }}"
    state: present
  loop:
    - git
    # ここに追加したいパッケージを記載
```

### dotfiles を追加する

1. `dotfiles/` ディレクトリに設定ファイルを追加する
2. `ansible/roles/dotfiles/tasks/main.yml` の `loop` にファイル名を追加する

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
| git | バージョン管理 |
| curl | HTTP クライアント |
| tree | ディレクトリ表示 |
| ansible | 構成管理ツール |
| eza | 高機能 `ls` 代替 |
| lcov | カバレッジ計測ツール |
| docker-compose | コンテナオーケストレーション |
| hadolint | Dockerfileリンター |
| starship | クロスシェルプロンプト |
| mise | 開発ツールバージョン管理 |
| delta | 差分ビューア |
| sheldon | Zshプラグインマネージャー |

### アプリケーション（brew cask）

| アプリ | 説明 |
|--------|------|
| Visual Studio Code | コードエディタ |
| WezTerm | ターミナルエミュレータ |
| Google Chrome | ウェブブラウザ |
| Docker | コンテナ実行環境 |
| FiraCode Nerd Font | 開発用フォント |
| Android Studio | Android IDE |

---

## 🖥️ macOS システム設定

Ansible 実行時に以下の設定が適用されます。

- Dock の自動非表示を有効化
- Finder で隠しファイルを表示
- ファイル拡張子を常に表示

---

## 📄 ライセンス

[MIT License](LICENSE)