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

if command -v systemctl &>/dev/null; then
  systemctl --user import-environment DISPLAY
fi

if [[ "$(hostname)" == "rey" ]]; then
  export WINIT_X11_SCALE_FACTOR=2
fi
