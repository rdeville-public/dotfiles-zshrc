#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/python.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of alias and method to manage python files

# METHOD
# =============================================================================
pyclean()
{
  # Remove python compiled byte-code and mypy cache in either current
  # directory or in a list of specified directories
  PYCLEAN_PLACES=${*:-'.'}
  find "${PYCLEAN_PLACES}" -type f -name "*.py[co]" -delete
  find "${PYCLEAN_PLACES}" -type d -name "__pycache__" -delete
  find "${PYCLEAN_PLACES}" -type d -name ".mypy_cache" -delete

}

# ALIAS
# =============================================================================
# Find python file
alias pyfind='find . -name "*.py"'
# Grep among .py files
alias pygrep='grep --include="*.py"'

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
