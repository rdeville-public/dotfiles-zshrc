#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/notify.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Desktop notifications for lon running command in ZSH
# From https://github.com/marzocchi/zsh-notify

if [[ "${SHELL}" =~ zsh ]]
then
  # METHOD
  # ===========================================================================
  notify-if-background()
  {
    # notify-if-background will exit with status 1 if the terminal application is
    # not one for which we know how to query the "frontmost/background" status,
    # and with status 2 if the terminal application or the current shell
    # tab/window is active. See README.md for configuration options.
    #
    find-current-term-id()
    {
      # Find a "term_id", a string that will be used later to dispatch different
      # commands to determine whether the terminal application is active or in
      # background.
      #
      local resources_dir
      zstyle -s ':notify:' resources-dir resources_dir

      if [[ "$TERM_PROGRAM" == 'iTerm.app' ]]; then
          echo iterm2
      elif [[ "$TERM_PROGRAM" == 'Apple_Terminal' ]]; then
          echo apple-terminal
      elif [[ "$DISPLAY" != '' ]] && command -v xdotool > /dev/null 2>&1; then
          echo xdotool
      else
          return 1
      fi

    }

    is-inside-tmux()
    {
      # Exit with 0 if inside a TMUX pane
      #
      if [[ -z "$TMUX" ]]; then
          return 1
      else
          return 0
      fi

    }

    find-current-tty()
    {
      # Find the TTY for the current shell.
      #
      if is-inside-tmux; then
        tmux display-message -p '#{client_tty}'
      else
        echo "$TTY"
      fi

    }

    find-tmux-pane()
    {
      # Get the active TMUX pane ID, comparable with $TMUX_PANE
      #
      if is-inside-tmux; then
          tmux list-windows -F '#{window_active} #{pane_id}' | grep -i '^1' | awk '{ print $2 }'
      else
          return 1
      fi

    }

    is-tmux-pane-active()
    {
      # Exit with 0 if given TMUX pane is the active one.
      #
      local pane
      pane=$1

      # shellcheck disable=SC2153
      # - SC2153: Possible misspelling: TMUX_PANE may not be assigned, but tmux_pane is.
      if [[ "$TMUX_PANE" == "$pane" ]]; then
          return 0
      fi

      return 1

    }

    is-terminal-window-active()
    {
      # Exit with 0 if the terminal window/tab is active; exit with 1 if not, or
      # if the terminal is
      #
      local term_id

      term_id=$1

      case "$term_id" in
          "iterm2"|"apple-terminal")
              local current_tty resources_dir

              zstyle -s ':notify:' resources-dir resources_dir
              current_tty=$(find-current-tty)

              if [[ "true" == $(osascript "$resources_dir"/is-"$term_id"-active.applescript "$current_tty") ]]; then
                  return 0
              fi
          ;;
          "xdotool")
              local active_wid wid

              active_wid=$(xdotool getactivewindow)

              zstyle -s ':notify:' window-pid wid             || zstyle -s ':notify:' parent-pid wid

              if [[ "$active_wid" == "$wid" ]]; then
                  return 0
              fi
          ;;
      esac
      return 1

    }

    is-in-background()
    {
      # Detect if the terminal application is in background, also accounting
      # for TMUX if needed, exiting with status 1 if it's active.
      #
      local term_id

      term_id=$1

      if is-terminal-window-active "$term_id"; then
          if is-inside-tmux; then
              local tmux_pane

              tmux_pane=$(find-tmux-pane)

              if is-tmux-pane-active "$tmux_pane"; then
                  return 1
              else
                  return 0
              fi
          fi
          return 1
      fi

      return 0

    }

    notifier()
    {
      replace_vars()
      {
        local text

        text="$1"

        # shellcheck disable=SC2154
        # - SC2154: vars is referenced but not assigned
        for k in ${(@k)vars}; do
          v="${vars[$k]}"
          text="${text/#{$k}/$v}"
        done

        echo "$text"

      }

      notifier-mac()
      {
        local app_id app_id_option

        if [[ "$TERM_PROGRAM" == 'iTerm.app' ]]; then
            app_id="com.googlecode.iterm2"
        elif [[ "$TERM_PROGRAM" == 'Apple_Terminal' ]]; then
            app_id="com.apple.terminal"
        fi

        # shellcheck disable=SC2034
        #  SC2034: app_id_option appears unused. Verify use (or export if
        #          used externally).
        if [[ -n "$app_id" ]]; then
            app_id_option="-activate $app_id"
        fi

        # shellcheck disable=SC2154
        # - SC2154: vars is referenced but not assigned
        echo "$message" | terminal-notifier "${=app_id_option}" "${=sound_option}"                     -appIcon "$icon" -title "$notification_title" > /dev/null 2>&1

        if zstyle -t ':notify:' activate-terminal; then
            echo tell app id \"$app_id\" to activate | osascript 1>/dev/null
        fi

      }

      notifier-linux()
      {
        notify-send -i "$icon" "$notification_title" "$message"

        if command -v wmctrl > /dev/null 2>&1; then
            local parent_pid

            zstyle -s ':notify:' parent-pid parent_pid

            if zstyle -t ':notify:' activate-terminal; then
                wmctrl -ia "$(wmctrl -lp | awk -vpid="$parent_pid" '$3==pid {print $1; exit}')"
            elif ! (zstyle -t ':notify:' disable-urgent); then
                wmctrl -i -r "$(wmctrl -lp | awk -vpid="$parent_pid" '$3==pid {print $1; exit}')"           -b add,demands_attention
            fi
        fi

      }

      local notification_title message type
      local -A titles
      local -A vars

      # shellcheck disable=SC2190
      # - SC2190: Elements in associative arrays need index, e.g. array=(
      #           [index]=value )
      titles=(error "#fail" success "#win")
      type=$1
      time_elapsed=$2
      # shellcheck disable=SC2190
      # - SC2190: Elements in associative arrays need index, e.g. array=(
      #           [index]=value )
      vars=(time_elapsed "$time_elapsed")

      message=$(<&0)
      zstyle -s ':notify:' "$type"-title notification_title     || notification_title="${titles[$type]}"

      notification_title=$(replace_vars "$notification_title")

      zstyle -s ':notify:' "$type"-sound notification_sound
      zstyle -s ':notify:' "$type"-icon icon

      if command -v terminal-notifier > /dev/null 2>&1; then
          notifier-mac
      elif command -v notify-send > /dev/null 2>&1; then
          notifier-linux
      else
          echo "No notifier program found." >&2
          return 1
      fi

    }

    local term_id type message notifier

    type=$1
    time_elapsed="$2"
    message=$(<&0)

    zstyle -s ':notify:' error-log error_log   || error_log=/dev/stderr

    (
      term_id=$(find-current-term-id)       || return 1

      is-in-background "$term_id"       || return 2

      zstyle -s ':notify:' notifier notifier       || notifier=notifier

      echo "$message" | "$notifier" "$type" "$time_elapsed"
    ) 2> "$error_log"

  }

  notify-error()
  {
    # Notify an error with no regard to the time elapsed (but always only
    # when the terminal is in background).
    #
    local time_elapsed
    time_elapsed=$1
    # shellcheck disable=SC1035,SC1072
    # - SC1035: You are missing a required space after the !.
    # - SC1072: Expected a command.  Fix any mentioned problems and try again.
    notify-if-background error "$time_elapsed" < /dev/stdin &!

  }

  notify-success()
  {
    # Notify of successful command termination, but only if it took at least
    # 30 seconds (and if the terminal is in background).
    #
    local time_elapsed command_complete_timeout

    time_elapsed=$1

    zstyle -s ':notify:' command-complete-timeout command_complete_timeout     || command_complete_timeout=30

    # shellcheck disable=SC1035,SC1072
    # - SC1035: You are missing a required space after the !.
    # - SC1072: Expected a command.  Fix any mentioned problems and try again.
    if (( time_elapsed > command_complete_timeout )); then
        notify-if-background success "$time_elapsed" < /dev/stdin &!
    fi

  }

  notify-command-complete()
  {
    # Notify about the last command's success or failure.
    #
    last_status=$?

    local now time_elapsed

    # shellcheck disable=SC2190
    # - SC2190: Elements in associative arrays need index, e.g. array=(
    #           [index]=value )
    if [[ -n $start_time ]]; then
      now=$(date "+%s")
      ((time_elapsed = now - start_time ))
      if [[ $last_status -gt "0" ]]; then
          notify-error "$time_elapsed" <<< "$last_command"
      elif [[ -n $start_time ]]; then
          notify-success "$time_elapsed" <<< "$last_command"
      fi
    fi
    unset last_command last_status start_time

  }

  store-command-stats()
  {
    last_command=$1
    start_time=$(date "+%s")

  }

  # COMPLETION
  # ===========================================================================
  zstyle ':notify:*' resources-dir "$(dirname "$0":A)/resources"
  zstyle ':notify:*' command-complete-timeout 15
  zstyle ':notify:*' window-pid "$WINDOWID"
  test -z "$_ZSH_NOTIFY_ROOT_PPID" && export _ZSH_NOTIFY_ROOT_PPID="$PPID"
  zstyle ':notify:*' parent-pid $_ZSH_NOTIFY_ROOT_PPID
  autoload add-zsh-hook
  autoload -U notify-if-background
  add-zsh-hook preexec store-command-stats
  add-zsh-hook precmd notify-command-complete
  zstyle ':notify:*' error-title "Command failed (in ${time_elapsed} seconds)"
  zstyle ':notify:*' error-icon "/path/to/error-icon.png"
  zstyle ':notify:*' success-title "Command finished (in ${time_elapsed} seconds)"
  zstyle ':notify:*' success-icon "${HOME}/download/yeah.gif"

fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
