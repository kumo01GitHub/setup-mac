# .config/zsh/.zshrc

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Aliases
alias cat='bat --style=plain --paging=never'
alias ls='eza'
alias ll='eza -la'
alias la='eza -a'
alias l='eza'
alias diff='delta'

# XDG preferred paths for tools (XDG variables are set in ~/.zshenv)

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

# Flutter / Dart
export PUB_CACHE="${PUB_CACHE:-$XDG_CACHE_HOME/pub}"

# Ensure state dir for history exists
mkdir -p "$XDG_STATE_HOME/zsh"
mkdir -p "$XDG_STATE_HOME/less" "$XDG_STATE_HOME/vim"

# Path
export PATH="$NPM_CONFIG_PREFIX/bin:$HOME/.local/bin:$PATH"

# History
HISTFILE="$XDG_STATE_HOME/zsh/history"
export LESSHISTFILE="${LESSHISTFILE:-$XDG_STATE_HOME/less/history}"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# Plugins
eval "$(sheldon source)"

# Prompt
eval "$(starship init zsh)"

# mise
eval "$(mise activate zsh)"
