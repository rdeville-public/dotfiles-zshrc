#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/direnv.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of alias, method, completion, etc. for direnv

if command -v direnv > /dev/null 2>&1
then
  # ALIAS
  # ===========================================================================
  alias da="direnv allow"
  alias de="direnv edit"
  alias dr="direnv reload"
  alias ds="direnv status"

  # COMPLETION
  # ===========================================================================
  case ${SHELL} in
    *bash)
      source <(direnv hook bash)
      ;;
    *zsh)
      source <(direnv hook zsh)
      ;;
  esac
fi
# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
