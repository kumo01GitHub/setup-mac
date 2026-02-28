# .zshenv - set XDG dirs and ZDOTDIR early for zsh
# This file is sourced very early by zsh; keep it minimal and fast.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Put zsh dotfiles under XDG config
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# Ensure zsh config/state/cache dirs exist
mkdir -p "$ZDOTDIR" "$XDG_STATE_HOME/zsh" "$XDG_CACHE_HOME/zsh"
