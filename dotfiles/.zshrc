# .zshrc

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# XDG Base Directory
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# XDG preferred paths for tools

# Homebrew
export HOMEBREW_CACHE="${HOMEBREW_CACHE:-$XDG_CACHE_HOME/Homebrew}"
export HOMEBREW_LOGS="${HOMEBREW_LOGS:-$XDG_STATE_HOME/Homebrew/logs}"

# Ansible
export ANSIBLE_HOME="${ANSIBLE_HOME:-$XDG_DATA_HOME/ansible}"
export ANSIBLE_LOCAL_TEMP="${ANSIBLE_LOCAL_TEMP:-$XDG_CACHE_HOME/ansible/tmp}"

# Android / Gradle
export ANDROID_USER_HOME="${ANDROID_USER_HOME:-$XDG_DATA_HOME/android}"
export GRADLE_USER_HOME="${GRADLE_USER_HOME:-$XDG_DATA_HOME/gradle}"

# Docker / Hadolint
export DOCKER_CONFIG="${DOCKER_CONFIG:-$XDG_CONFIG_HOME/docker}"
export HADOLINT_CONFIG="${HADOLINT_CONFIG:-$XDG_CONFIG_HOME/hadolint.yaml}"

# mise
export MISE_DATA_DIR="${MISE_DATA_DIR:-$XDG_DATA_HOME/mise}"
export MISE_CACHE_DIR="${MISE_CACHE_DIR:-$XDG_CACHE_HOME/mise}"
export MISE_CONFIG_DIR="${MISE_CONFIG_DIR:-$XDG_CONFIG_HOME/mise}"

# Node.js / npm
export NPM_CONFIG_USERCONFIG="${NPM_CONFIG_USERCONFIG:-$XDG_CONFIG_HOME/npm/npmrc}"
export NPM_CONFIG_CACHE="${NPM_CONFIG_CACHE:-$XDG_CACHE_HOME/npm}"
export NPM_CONFIG_PREFIX="${NPM_CONFIG_PREFIX:-$XDG_DATA_HOME/npm}"

# Python / pip
export PIP_CONFIG_FILE="${PIP_CONFIG_FILE:-$XDG_CONFIG_HOME/pip/pip.conf}"
export PIP_CACHE_DIR="${PIP_CACHE_DIR:-$XDG_CACHE_HOME/pip}"
export PYTHONPYCACHEPREFIX="${PYTHONPYCACHEPREFIX:-$XDG_CACHE_HOME/python/pycache}"

# RubyGems / CocoaPods
export GEM_SPEC_CACHE="${GEM_SPEC_CACHE:-$XDG_CACHE_HOME/gem/specs}"
export CP_HOME_DIR="${CP_HOME_DIR:-$XDG_DATA_HOME/cocoapods}"

# VS Code
export VSCODE_USER_DATA_DIR="${VSCODE_USER_DATA_DIR:-$XDG_DATA_HOME/vscode/user-data}"
export VSCODE_EXTENSIONS_DIR="${VSCODE_EXTENSIONS_DIR:-$XDG_DATA_HOME/vscode/extensions}"

# Ensure required XDG directories exist before tools run
mkdir -p "$HOMEBREW_CACHE" "$HOMEBREW_LOGS" "$ANSIBLE_LOCAL_TEMP" "$ANDROID_USER_HOME" "$GRADLE_USER_HOME" "$DOCKER_CONFIG" "$MISE_DATA_DIR" "$MISE_CACHE_DIR" "$MISE_CONFIG_DIR" "$VSCODE_USER_DATA_DIR" "$VSCODE_EXTENSIONS_DIR" "$NPM_CONFIG_CACHE" "$NPM_CONFIG_PREFIX" "$(dirname "$NPM_CONFIG_USERCONFIG")" "$PIP_CACHE_DIR" "$(dirname "$PIP_CONFIG_FILE")" "$PYTHONPYCACHEPREFIX" "$GEM_SPEC_CACHE" "$CP_HOME_DIR"
mkdir -p "$(dirname "$HADOLINT_CONFIG")"

# Launch VS Code with XDG-based user-data/extensions paths
code() {
	command code --user-data-dir "$VSCODE_USER_DATA_DIR" --extensions-dir "$VSCODE_EXTENSIONS_DIR" "$@"
}

# Path
# npm global bin and local user bin
export PATH="$NPM_CONFIG_PREFIX/bin:$HOME/.local/bin:$PATH"

# mise
# Enable shims for node/python/java/gradle/ruby managed by mise
eval "$(mise activate zsh)"

# Aliases
alias ll='eza -la'
alias la='eza -a'
alias l='eza'
alias diff='delta'

# History
# Store shell history under XDG state directory
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
