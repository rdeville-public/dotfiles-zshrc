#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/03.git-extras.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of alias for git-extras

if command -v git-extras > /dev/null 2>&1
then
  # METHOD
  # ===========================================================================
  gitignore()
  {
    # Check if template as $1 exist in gitignore.io and is not already in
    # .gitignore file. Then add it to .gitignore file
    local template=$1
    local gitignore
    local content=$(curl https://gitignore.io/api/${template} 2> /dev/null)

    if command -v git &> /dev/null \
      && [[ -n "$(git rev-parse --is-inside-work-tree 2> /dev/null)" ]]
    then
      gitignore="$(git rev-parse --show-toplevel)/.gitignore"
    fi

    if [[ "${content}" =~ "^#!! ERROR:"  ]]
    then
      echo "ERROR-Not template for '${template}' in gitignore.io"
    elif [[ -z "${gitignore}" ]]
    then
      echo "Content of ${template} that should be added to gitignore"
      echo "${content}"
    elif ! grep -q "# End of https://www.gitignore.io/api/${template}" "${gitignore}" > /dev/null 2>&1
    then
      echo "${content}" >> "${gitignore}"
      echo "Adding template of ${template} in .gitignore"
    else
      echo "Template for '${template}' already in .gitignore"
    fi
  }

  # COMPLETION
  # ===========================================================================
  # shellcheck disable=SC1090
  # - SC1090 : Can't follow non-constant source. Use a directive to specify location.
  if [[ "${SHELL}" =~ bash ]]
  then
    source ${SHELL_DIR}/completion/git-extras.bash
  elif [[ "${SHELL}" =~ zsh ]]
  then
    source ${SHELL_DIR}/completion/git-extras.zsh
  fi

fi

# ******************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# ******************************************************************************
