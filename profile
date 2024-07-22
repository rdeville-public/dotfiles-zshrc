#!/usr/bin/env bash

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# See /usr/share/doc/bash/examples/startup-files for examples.
# The files are located in the bash-doc package.

export LC_ALL="en_US.UTF-8"

# export GNUPGHOME="${HOME}/.config/gnupg"
# shellcheck disable=SC2155
export HOST=$(hostname)
# shellcheck disable=SC2155
export SHELL="$(which zsh)"

systemctl --user import-environment DISPLAY

if [[ "$(hostname)" == "rey" ]]; then
  export WINIT_X11_SCALE_FACTOR=2
fi

# GUI
# -----------------------------------------------------------------------------
# If screen can be graphical, run xserver
if systemctl -q is-active graphical.target &&
  [[ -z "${DISPLAY}" ]]; then
  # Uncomment below condition to only start xserver on first tty
  # && [[ "${XDG_VTNR}" -eq 1 ]]; then
  startx
fi
