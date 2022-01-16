#!/usr/bin/env sh
# enable bash completion in interactive shells
# shellcheck disable=SC1091
# - SC1091 : Not following: file was not specified as input
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

if ! [[ "${PROMPT_COMMAND}" =~ precmd ]]
then
  PROMPT_COMMAND="precmd;${PROMPT_COMMAND}"
fi

if ! [[ "$(tty)" =~ *pty* ]]
then
  # Up Arrow recognize by st and xterm can have two key : \eOA and \e[A
  # Reverse command search
  bind '"\eOA":history-search-backward'
  # Reverse history search
  bind '"\e[A":previous-history'
  # Forward command search
  bind '"\eOB":history-search-forward'
  # Forward history search
  bind '"\e[B":next-history'
fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
