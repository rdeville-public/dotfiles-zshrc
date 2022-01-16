#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/makefile.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of completion command for makefile

if command -v make > /dev/null 2>&1
then
  # COMPLETION
  # ===========================================================================
  if [[ "${SHELL}" =~ bash ]]
  then
    complete -W "\`grep -oE '^[a-zA-Z0-9_-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_-]*$//'\`" make
  elif [[ "${SHELL}" =~ zsh ]]
  then
    zstyle ':completion:*:make:*:variables' call-command false
    zstyle ':completion:*:make:*' tag-order targets variables
    zstyle ':completion:*:make:*' group-name ''
    zstyle ':completion:*:make:*:descriptions' format '%B%F3%d%b'
  fi

fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
