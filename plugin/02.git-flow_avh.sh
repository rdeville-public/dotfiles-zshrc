#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/02.git-flow_avh.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of alias and completion for git-flow avh version

if git flow version > /dev/null 2>&1
then
  # ALIAS
  # ===========================================================================
  alias gfl='git flow'
  alias gfli='git flow init'
  alias gcd='git checkout develop'
  alias gch='git checkout hotfix'
  alias gcr='git checkout release'
  alias gflf='git flow feature'
  alias gflh='git flow hotfix'
  alias gflr='git flow release'
  alias gflfs='git flow feature start'
  alias gflhs='git flow hotfix start'
  alias gflrs='git flow release start'
  alias gflff='git flow feature finish'
  alias gflfp='git flow feature publish'
  alias gflhf='git flow hotfix finish'
  alias gflrf='git flow release finish'
  alias gflfp='git flow feature publish'
  alias gflhp='git flow hotfix publish'
  alias gflrp='git flow release publish'
  alias gflfpll='git flow feature pull'

  # COMPLETION
  # ===========================================================================
  # shellcheck disable=SC1090
  # - SC1090 : Can't follow non-constant source. Use a directive to specify location.
  if [[ "${SHELL}" =~ bash ]]
  then
    source ${SHELL_DIR}/completion/git-flow_avh.bash
  elif [[ "${SHELL}" =~ zsh ]]
  then
    source ${SHELL_DIR}/completion/git-flow_avh.zsh
  fi

fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
