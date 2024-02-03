#!/usr/bin/env bash

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

export LC_ALL="en_US.UTF-8"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_DATA_DIRS="${XDG_DATA_HOME}:/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="${XDG_CONFIG_HOME}:/etc/xdg"

# Export SSH_AUTH_SOCK for keepass
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
export SSH_ASKPASS="/usr/bin/ssh-askpass"

export GNUPGHOME="${HOME}/.config/gnupg"

if [[ "$(hostname)" == "rey" ]]
then
  export WINIT_X11_SCALE_FACTOR=1
fi

# If running bash
if [[ -n "$BASH_VERSION" ]] && [[ -f "$HOME/.bashrc" ]]
then
  # shellcheck disable=1091
  source  "$HOME/.bashrc"
fi

# GUI
# -----------------------------------------------------------------------------
# If screen is can be graphical, run xserver
if systemctl -q is-active graphical.target \
    && [[ -z "${DISPLAY}" ]] \
    && [[ "${XDG_VTNR}" -eq 1 ]]
then
  startx
fi

