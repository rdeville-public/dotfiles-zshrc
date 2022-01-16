#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/colorize.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of alias for ansible and derivative ansible command

if command -v pygmentize > /dev/null 2>&1
then
  # METHOD
  # ===========================================================================
  ccat()
  {
    # pygmentize stdin if no arguments passed
    if [ $# -eq 0 ]; then
        pygmentize -g
        return $?
    fi

    # guess lexer from file extension, or
    # guess it from file contents if unsuccessful
    local FNAME lexer
    for FNAME in "$@"
    do
      lexer=$(pygmentize -N "$FNAME")
      if [[ $lexer != text ]]
      then
        pygmentize -l "$lexer" "$FNAME"
      else
        pygmentize -g "$FNAME"
      fi
    done
  }

fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
