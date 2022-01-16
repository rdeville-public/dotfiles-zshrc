#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/systemd.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of systemd alias

# VARIABLE
# =============================================================================
user_commands=(
  "list-units"
  "is-active"
  "status"
  "show"
  "help"
  "list-unit-files"
  "is-enabled"
  "list-jobs"
  "show-environment"
  "cat"
  "list-timers"
)

sudo_commands=(
  "start"
  "stop"
  "reload"
  "restart"
  "try-restart"
  "isolate"
  "kill"
  "reset-failed"
  "enable"
  "disable"
  "reenable"
  "preset"
  "mask"
  "unmask"
  "link"
  "load"
  "cancel"
  "set-environment"
  "unset-environment"
  "edit"
)

# ALIAS
# =============================================================================
if [[ $(whoami) == "root" ]]
then
  for c in "${user_commands[@]}"
  do
    # shellcheck disable=SC2139,SC2086
    # - SC2139: This expands when defined, not when used. Consider escaping.
    # - SC2086: Double quote to prevent globbing and word splitting.
    alias sc-$c="systemctl $c"
  done

  for c in "${user_commands[@]}"
  do
    # shellcheck disable=SC2139,SC2086
    # - SC2139: This expands when defined, not when used. Consider escaping.
    # - SC2086: Double quote to prevent globbing and word splitting.
    alias scu-$c="systemctl --user $c"
  done
else
  for c in "${sudo_commands[@]}"
  do
    # shellcheck disable=SC2139,SC2086
    # - SC2139: This expands when defined, not when used. Consider escaping.
    # - SC2086: Double quote to prevent globbing and word splitting.
    alias sc-$c="sudo systemctl $c"
  done

  for c in "${sudo_commands[@]}"
  do
    # shellcheck disable=SC2139,SC2086
    # - SC2139: This expands when defined, not when used. Consider escaping.
    # - SC2086: Double quote to prevent globbing and word splitting.
    alias scu-$c="systemctl --user $c"
  done
fi

alias sc-enable-now='sc-enable --now'
alias sc-disable-now='sc-disable --now'
alias sc-mask-now='sc-mask --now'
alias scu-enable-now='scu-enable --now'
alias scu-disable-now='scu-disable --now'
alias scu-mask-now='scu-mask --now'

# ******************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# ******************************************************************************
