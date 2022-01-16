#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/vim.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of vim alias

# ALIAS
# =============================================================================

if command -v vim > /dev/null 2>&1
then
  #alias vim='vim --servername local'
  alias v='vim'
  alias vd='vimdiff'
  alias svim='sudo vim'
  alias sv='sudo vim'
  alias vim='vim -u ~/.config/vim/vimrc'

fi


if command -v nvim > /dev/null 2>&1
then
  alias vimdiff='nvim -d'
  #alias nvim='vim --servername local'
  alias vim='nvim'
  alias nv='nvim'
  alias snvim='sudo vim'
  alias snv='sudo vim'
  #alias vim='vim --servername local'
  alias v='vim'
  alias vd='vimdiff'
  alias svim='sudo vim'
  alias sv='sudo vim'
fi


# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
