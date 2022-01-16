#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/ssh.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of ssh completion

# METHOD
# =============================================================================
_sshcomplete()
{
  local CURRENT_PROMPT="${COMP_WORDS[COMP_CWORD]}"
  if [[ ${CURRENT_PROMPT} == *@*  ]] ; then
    local OPTIONS="-P ${CURRENT_PROMPT/@*/}@ -- ${CURRENT_PROMPT/*@/}"
  else
    local OPTIONS=" -- ${CURRENT_PROMPT}"
  fi

  # parse all defined hosts from .ssh/config and files included there
  for fl in "$HOME/.ssh/config"   $(grep "^\s*Include" "$HOME/.ssh/config" |
      awk '{for (i=2; i<=NF; i++) print $i}' |
      sed "s|^~/|$HOME/|")
  do
    # shellcheck disable=SC2207
    # - SC2207 : Prefer mapfile or read -a to split command output (or quote
    #            to avoid splitting).
    if [ -r "$fl" ]
    then
      COMPREPLY=( "${COMPREPLY[@]}"       \
          $(compgen -W "$(grep -i ^Host "$fl" | grep -v '[*!]' \
          | awk '{for (i=2; i<=NF; i++) print $i}' )"         "${OPTIONS}") )
    fi
  done

  # parse all hosts found in .ssh/known_hosts
  # shellcheck disable=SC2207
  # - SC2207 : Prefer mapfile or read -a to split command output (or quote
  #            to avoid splitting).
  if [ -r "$HOME/.ssh/known_hosts" ]
  then
    if grep -v -q -e '^ ssh-rsa' "$HOME/.ssh/known_hosts"
    then
      COMPREPLY=( "${COMPREPLY[@]}" \
          $(compgen -W "$(awk '{print $1}' "$HOME/.ssh/known_hosts" \
          | grep -v ^\| | cut -d, -f 1 | sed -e 's/\[//g' \
          | sed -e 's/\]//g' | cut -d: -f1 | grep -v ssh-rsa)" \
          "${OPTIONS}") )
      fi
  fi

  # parse hosts defined in /etc/hosts
  # shellcheck disable=SC2207
  # - SC2207 : Prefer mapfile or read -a to split command output (or quote
  #            to avoid splitting).
  if [ -r /etc/hosts ]; then
      COMPREPLY=( "${COMPREPLY[@]}" \
          $(compgen -W "$(grep -v '^[[:space:]]*$' /etc/hosts | grep -v '^#' \
          | awk '{for (i=2; i<=NF; i++) print $i}' )" \
          "${OPTIONS}") )
  fi

  return 0

}

if [[ "${SHELL}" == "bash" ]]
then
  complete -o default -o nospace -F _sshcomplete ssh scp
fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
