#!/usr/bin/env bash

# Make ZSH able to read bash autocompletion files
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
# ls colors
autoload -U colors && colors
# Move zcompdump file (i.e. autocompletion cache for zsh)
compinit -d "${HOME}/.cache/zsh/zcompdump-$ZSH_VERSION"

export EDITOR="nvim"
export PATH="$HOME/.local/share/bin:$HOME/.local/bin:$PATH"
# Required for nix on non-NixOS
# See: https://nixos.wiki/wiki/Locales
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

if command -v tmux &>/dev/null &&
  [[ -n "$PS1" ]] &&
  [[ -z "${VIMRUNTIME}" ]] &&
  [[ -z "$TMUX" ]] &&
  [[ ! "$TERM" =~ (screen|tmux) ]]; then
  if command -v tmuxp &>/dev/null; then
    tmuxp load -y "${TMUXP_CONFIG:-home}"
  else
    tmux
  fi
fi

# ZSH_DOT_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh"
ZSH_DOT_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/shell"
command -v dircolors &>/dev/null && eval "$(dircolors "${ZSH_DOT_DIR}/LS_COLORS")"

source_dir() {
  local dir=$1
  for file in "${dir}"/*; do
    # shellcheck disable=SC1090
    source "${file}"
  done
}

source_dir "${ZSH_DOT_DIR}/config"
source_dir "${ZSH_DOT_DIR}/plugins"

if command -v fastfetch >/dev/null 2>&1 &&
  [[ -z "${VIRTUAL_ENV}" ]] &&
  [[ -z "${VIMRUNTIME}" ]]; then
  fastfetch
fi

# DO NOT MOVE IT TO PLUGINS FOLDER TO ENSURE LOADED LAST
command -v starship &>/dev/null && eval "$(starship init zsh)"
