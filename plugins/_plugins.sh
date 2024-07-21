#!/usr/bin/env bash

# Set of simple "plugins" without much config

# Autocompletion
command -v atuin &>/dev/null && eval "$(atuin init zsh)"
command -v thefuck &>/dev/null && eval "$(thefuck --alias)"
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# Alias
command -v lazygit &>/dev/null && alias lz=lazygit
command -v zathura &>/dev/null && alias za="zathura --fork"
