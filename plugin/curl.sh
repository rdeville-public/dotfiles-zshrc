#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/curl.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of curl alias

if command -v curl > /dev/null
then
  # ALIAS
  # ===========================================================================
  # Follow redirects
  alias cl='curl -L'
  # Follow redirects, download as original name
  alias clo='curl -L -O'
  # Follow redirects, download as original name, continue
  alias cloc='curl -L -C - -O'
  # Follow redirects, download as original name, continue, retry 5 times
  alias clocr='curl -L -C - -O --retry 5'
  # Follow redirects, fetch banner
  alias clb='curl -L -I'
  # See only response headers from a get request
  alias clhead='curl -D - -so /dev/null'

fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
