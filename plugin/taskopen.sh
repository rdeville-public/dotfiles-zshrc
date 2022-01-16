#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/taskopen.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of general alias for taskopen

if command -v taskopen > /dev/null 2>&1
then
  # ALIAS
  # ===========================================================================
  if [[ -n "${TASKOPENRC}" ]]
  then
    alias taskopen="taskopen -c ${TASKOPENRC}"
  fi
fi

