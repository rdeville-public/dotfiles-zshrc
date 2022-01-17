#!/usr/bin/env sh
# *****************************************************************************
# File    : ~/.shellrc.d/lib/correction.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION
# =============================================================================
# Set of correction command

# OPTIONS
# =============================================================================
if [[ "${SHELL}" =~ zsh ]]
then
  # Forbid zsh to correct following command
  alias cp='nocorrect cp'
  alias gist='nocorrect gist'
  alias mkdir='nocorrect mkdir'
  alias mv='nocorrect mv'
  alias sudo='nocorrect sudo'
  alias vim='nocorrect vim'

  setopt correct
elif [[ "${SHELL}" =~ bash ]]
then
  # If set, a command name that is the name of a directory is executed as if
  # it were the argument to the cd command. This option is only used by
  # interactive shells.
  shopt -s autocd

  # If set, minor errors in the spelling of a directory component in a cd
  # command will be corrected. The errors checked for are transposed
  # characters, a missing character, and a character too many. If a
  # correction is found, the corrected path is printed, and the command
  # proceeds. This option is only used by interactive shells.
  shopt -s cdspell
fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
