#!/usr/bin/env bash

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
# History file
[[ -z "$HISTFILE" ]] && HISTFILE=${HOME}/.cache/zsh/zsh_history

# OPTIONS
# =============================================================================
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
