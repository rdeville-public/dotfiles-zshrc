#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/tmux.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of tmux alias
#
if command -v tmux > /dev/null
then
  # ALIAS
  # ===========================================================================
  alias ta='tmux attach -t'
  alias ts='tmux switch-client -t'
  alias tad='tmux attach -d -t'
  alias tl='tmux list-sessions'
  alias tksv='tmux kill-server'
  alias tkss='tmux kill-session -t'

  txl(){
    tmux attach -t "$(basename "$(pwd)")"
  }

  # COMPLETION
  # ===========================================================================
  if [[ ${SHELL} =~ bash ]]
  then
    _tmux_complete_client()
    {
      local IFS=$'\n'
      local cur="${1}"
      # shellcheck disable=SC2207
      # - SC2207: Prefer mapfile or read -a to split command output (or
      #           quote to avoid splitting).
      COMPREPLY=( "${COMPREPLY[@]:-}" \
        $(compgen -W "$(tmux list-clients -F '#{client_tty}' 2> /dev/null)" -- "${cur}") )
      options=""
      return 0
    }

    _tmux_complete_session()
    {
      local IFS=$'\n'
      local cur="${1}"
      # shellcheck disable=SC2207
      # - SC2207: Prefer mapfile or read -a to split command output (or
      #           quote to avoid splitting).
      COMPREPLY=( "${COMPREPLY[@]:-}" \
        $(compgen -W "$(tmux list-sessions -F '#{session_name}' 2> /dev/null)" -- "${cur}") )
      options=""
      return 0

    }

    _tmux_complete_window()
    {
      local IFS=$'\n'
      local cur="${1}"
      local session_name
      local sessions

      session_name="$(echo "${cur}" | sed 's/\\//g' | cut -d ':' -f 1)"
      sessions="$(tmux list-sessions 2> /dev/null | sed -re 's/([^:]+:).*$/\1/')"
      if [[ -n "${session_name}" ]]; then
          sessions="${sessions} $(tmux list-windows -t "${session_name}" 2> /dev/null | sed -re 's/^([^:]+):.*$/'"${session_name}"':\1/')"
      fi
      cur="${cur/:/\\\\:}"
      sessions="${sessions/:/\\\\:}"
      # shellcheck disable=SC2207
      # - SC2207: Prefer mapfile or read -a to split command output (or
      #           quote to avoid splitting).
      COMPREPLY=( "${COMPREPLY[@]:-}" $(compgen -W "${sessions}" -- "${cur}") )
      options=""
      return 0

    }

    __tmux_init_completion()
    {
      COMPREPLY=()
      _get_comp_words_by_ref cur prev words cword
    }

    _tmux()
    {
      local cur prev words cword;
      if declare -F _init_completions >/dev/null 2>&1; then
          _init_completion
      else
          __tmux_init_completion
      fi
      # shellcheck disable=SC2207
      # - SC2207: Prefer mapfile or read -a to split command output (or
      #           quote to avoid splitting).
      if [[ $cword -eq 1 ]]; then
          COMPREPLY=($( compgen -W "$(tmux start\; list-commands | cut -d' ' -f1)" -- "$cur" ));
          return 0
      else
          case ${words[1]} in
              attach-session|attach)
              case "$prev" in
                  -t) _tmux_complete_session "${cur}" ;;
                  *) options="-t -d" ;;
              esac ;;
              detach-client|detach)
              case "$prev" in
                  -t) _tmux_complete_client "${cur}" ;;
                  *) options="-t" ;;
              esac ;;
              lock-client|lockc)
              case "$prev" in
                  -t) _tmux_complete_client "${cur}" ;;
                  *) options="-t" ;;
              esac ;;
              lock-session|locks)
              case "$prev" in
                  -t) _tmux_complete_session "${cur}" ;;
                  *) options="-t -d" ;;
              esac ;;
              new-session|new)
              case "$prev" in
                  -t) _tmux_complete_session "${cur}" ;;
                  -[n|d|s]) options="-d -n -s -t --" ;;
                  *)
                  if [[ ${COMP_WORDS[option_index]} == -- ]]; then
                      _command_offset "${option_index}"
                  else
                      options="-d -n -s -t --"
                  fi
                  ;;
              esac
              ;;
              refresh-client|refresh)
              case "$prev" in
                  -t) _tmux_complete_client "${cur}" ;;
                  *) options="-t" ;;
              esac ;;
              rename-session|rename)
              case "$prev" in
                  -t) _tmux_complete_session "${cur}" ;;
                  *) options="-t" ;;
              esac ;;
              has-session|has|kill-session)
              case "$prev" in
                  -t) _tmux_complete_session "${cur}" ;;
                  *) options="-t" ;;
              esac ;;
              source-file|source)
                  _filedir ;;
              suspend-client|suspendc)
              case "$prev" in
                  -t) _tmux_complete_client "${cur}" ;;
                  *) options="-t" ;;
              esac ;;
              switch-client|switchc)
              case "$prev" in
                  -c) _tmux_complete_client "${cur}" ;;
                  -t) _tmux_complete_session "${cur}" ;;
                  *) options="-l -n -p -c -t" ;;
              esac ;;
              send-keys|send)
              # shellcheck disable=SC2154
              # - SC2154: option is referenced but not assigned
              case "$option" in
                  -t) _tmux_complete_window "${cur}" ;;
                  *) options="-t" ;;
              esac ;;
            esac # case ${cmd}
      fi # command specified
      # shellcheck disable=SC2207
      # - SC2207: Prefer mapfile or read -a to split command output (or
      #           quote to avoid splitting).
      if [[ -n "${options}" ]]; then
          COMPREPLY=( "${COMPREPLY[@]:-}" $(compgen -W "${options}" -- "${cur}") )
      fi
        return 0
    }

    complete -F _tmux tmux
  fi
fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
