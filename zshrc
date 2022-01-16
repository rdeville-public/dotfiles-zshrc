#!/usr/bin/env zsh

PROMPT="precmd"

autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] \
  && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# Move zcompdump file (i.e. autocompletion cache for zsh)
compinit -d "${HOME}/.cache/zsh/zcompdump-$ZSH_VERSION"

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
