#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/helm.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of helm alias
#
if command -v helm > /dev/null 2>&1
then
  # ALIAS
  # ===========================================================================
  alias h='helm'

  # COMPLETION
  # ===========================================================================
  if [[ "${SHELL}" =~ bash ]]
  then
    source <(helm completion bash)
  elif [[ "${SHELL}" =~ zsh ]]
  then
    source <(helm completion zsh)
  fi
fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
