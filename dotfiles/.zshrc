# .zshrc

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# XDG Base Directory
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# XDG preferred paths for tools
export HOMEBREW_CACHE="${HOMEBREW_CACHE:-$XDG_CACHE_HOME/Homebrew}"
export HOMEBREW_LOGS="${HOMEBREW_LOGS:-$XDG_STATE_HOME/Homebrew/logs}"
export ANSIBLE_HOME="${ANSIBLE_HOME:-$XDG_DATA_HOME/ansible}"
export ANSIBLE_LOCAL_TEMP="${ANSIBLE_LOCAL_TEMP:-$XDG_CACHE_HOME/ansible/tmp}"
export ANDROID_USER_HOME="${ANDROID_USER_HOME:-$XDG_DATA_HOME/android}"
export GRADLE_USER_HOME="${GRADLE_USER_HOME:-$XDG_DATA_HOME/gradle}"
export DOCKER_CONFIG="${DOCKER_CONFIG:-$XDG_CONFIG_HOME/docker}"
export HADOLINT_CONFIG="${HADOLINT_CONFIG:-$XDG_CONFIG_HOME/hadolint.yaml}"
export MISE_DATA_DIR="${MISE_DATA_DIR:-$XDG_DATA_HOME/mise}"
export MISE_CACHE_DIR="${MISE_CACHE_DIR:-$XDG_CACHE_HOME/mise}"
export MISE_CONFIG_DIR="${MISE_CONFIG_DIR:-$XDG_CONFIG_HOME/mise}"
export VSCODE_USER_DATA_DIR="${VSCODE_USER_DATA_DIR:-$XDG_DATA_HOME/vscode/user-data}"
export VSCODE_EXTENSIONS_DIR="${VSCODE_EXTENSIONS_DIR:-$XDG_DATA_HOME/vscode/extensions}"

mkdir -p "$HOMEBREW_CACHE" "$HOMEBREW_LOGS" "$ANSIBLE_LOCAL_TEMP" "$ANDROID_USER_HOME" "$GRADLE_USER_HOME" "$DOCKER_CONFIG" "$MISE_DATA_DIR" "$MISE_CACHE_DIR" "$MISE_CONFIG_DIR" "$VSCODE_USER_DATA_DIR" "$VSCODE_EXTENSIONS_DIR"
mkdir -p "$(dirname "$HADOLINT_CONFIG")"

code() {
	command code --user-data-dir "$VSCODE_USER_DATA_DIR" --extensions-dir "$VSCODE_EXTENSIONS_DIR" "$@"
}

# Path
export PATH="$HOME/.local/bin:$PATH"

# Aliases
alias ll='eza -la'
alias la='eza -a'
alias l='eza'
alias diff='delta'

# History
mkdir -p "$XDG_STATE_HOME/zsh"
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# Plugins
eval "$(sheldon source)"

# Prompt
eval "$(starship init zsh)"
