#!/usr/bin/env sh
# *****************************************************************************
# File    : ~/.shellrc.d/lib/key-binding.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION
# =============================================================================
# Settings some keybindings for bash and zsh

# OPTIONS
# =============================================================================
if [[ "${SHELL}" =~ zsh ]]
then
  # Make sure that the terminal is in application mode when zle is active,
  # since only then values from $terminfo are valid
  # shellcheck disable=SC2154,SC2004
  # - SC2154: VAR is referenced but not assigned.
  # - SC2004: $/${} is unnecessary on arithmetic variables
  if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} ))
  then
    zle-line-init()
    {
      echoti smkx
    }

    zle-line-finish()
    {
      echoti rmkx
    }

    zle -N zle-line-init
    zle -N zle-line-finish
  fi

  # shellcheck disable=SC2154,SC2004
  # - SC2154 : VAR is referenced but not assigned.
  if [[ "${terminfo[kcuu1]}" != "" ]]
  then
    # start typing + Up-Arrow - fuzzy find history forward
    autoload -Uz up-line-or-beginning-search
    zle -N up-line-or-beginning-search
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
  fi

  if [[ "${terminfo[kcud1]}" != "" ]]
  then
    # start typing + Down-Arrow - fuzzy find history backward
    autoload -Uz down-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
  fi

  if [[ "${terminfo[khome]}" != "" ]]
  then
    # Home - Go to beginning of line
    bindkey "${terminfo[khome]}" beginning-of-line
  fi

  if [[ "${terminfo[kend]}" != "" ]]
  then
    # End - Go to end of line
    bindkey "${terminfo[kend]}"  end-of-line
  fi

  if [[ "${terminfo[kcbt]}" != "" ]]
  then
    # Shift-Tab - move through the completion menu backwards
    bindkey "${terminfo[kcbt]}" reverse-menu-complete
  fi

  if [[ "${terminfo[kdch1]}" != "" ]]
  then
    # Delete - delete forward
    bindkey "${terminfo[kdch1]}" delete-char
  else
    bindkey "^[[3~" delete-char
    bindkey "^[3;5~" delete-char
    bindkey "\e[3~" delete-char
  fi

  # Ctrl-r - Search backward incrementally for a specified string. The string
  # may begin with ^ to anchor the search to the beginning of the line.
  #
  bindkey '^r' history-incremental-search-backward
  # Ctrl-RightArrow - move forward one word
  bindkey '^[[1;5C' forward-word
  # Ctrl-LeftArrow - move backward one word
  bindkey '^[[1;5D' backward-word
  # Backspace - delete backward
  bindkey '^?' backward-delete-char
  # Edit the current command line in $EDITOR
  autoload -U edit-command-line
  zle -N edit-command-line
  bindkey '\C-x\C-e' edit-command-line

  # file rename magick
  bindkey "^[m" copy-prev-shell-word
  # consider emacs keybindings
  bindkey -e

  bindkey '^[[A' up-line-or-search
  bindkey '^[[B' down-line-or-search
  bindkey '^[^[[C' emacs-forward-word
  bindkey '^[^[[D' emacs-backward-word

  bindkey -s '^X^Z' '%-^M'
  bindkey '^[e' expand-cmd-path
  bindkey '^[^I' reverse-menu-complete
  bindkey '^X^N' accept-and-infer-next-history
  bindkey '^W' kill-region
  bindkey '^I' complete-word

  # Fix weird sequence that rxvt produces
  bindkey -s '^[[Z' '\t'
  autoload -U up-line-or-beginning-search
  bindkey "^[OA" up-line-or-beginning-search
fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
