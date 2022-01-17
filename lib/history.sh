#!/usr/bin/env sh
# *****************************************************************************
# File    : ~/.shellrc.d/lib/history.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION
# =============================================================================
# History file configuration

# VARIABLES
# =============================================================================
# Set history size
export HISTSIZE=50000
# Set history file size
export HISTFILESIZE=50000
# Set saved history
export SAVEHIST=50000

# Avoid duplica
export HISTCONTROL=ignoredups:erasedups

# OPTIONS
# =============================================================================
if [[ "${SHELL}" =~ bash ]]
then
  if [[ -z "${HISTFILE}" ]]
  then
    HISTFILE=${HOME}/.bash_history
  fi
  # When the shell exits, append to the history file instead of overwriting
  # it.
  shopt -s histappend

  # If set, and Readline is being used, a user is given the opportunity to
  # re-edit a failed history substitution.
  shopt -s histreedit

  # If set, and Readline is being used, the results of history substitution
  # are not immediately passed to the shell parser. Instead, the resulting
  # line is loaded into the Readline editing buffer, allowing further
  # modification.
  shopt -s histverify

  # If set, Bash attempts to save all lines of a multiple-line command in
  # the same history entry. This allows easy re-editing of multi-line
  # commands. This option is enabled by default, but only has an effect if
  # command history is enabled (see Bash History Facilities).
  shopt -s cmdhist

  # If enabled, and the cmdhist option is enabled, multi-line commands are
  # saved to the history with embedded newlines rather than using semicolon
  # separators where possible.
  shopt -s lithist
elif [[ "${SHELL}" =~ zsh ]]
then
  if [[ -z "$HISTFILE" ]]
  then
    HISTFILE=${HOME}/.zsh_history
  fi
  # Record timestamp of command in HISTFILE
  setopt extended_history
  # Delete duplicates first when HISTFILE size exceeds HISTSIZE
  setopt hist_expire_dups_first
  # Ignore duplicated commands history list
  setopt hist_ignore_dups
  # Ignore commands that start with space
  setopt hist_ignore_space
  # Show command with history expansion to user before running it
  setopt hist_verify
  # Add commands to HISTFILE in order of execution
  setopt inc_append_history
  # Share command history data
  setopt share_history
fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
