#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/rsync.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of alias for rsync

if command -v rsync > /dev/null 2>&1
then
  # METHOD
  # =============================================================================
  alias rsync-copy='rsync -avz --progress -h'
  alias rsync-move='rsync -avz --progress -h --remove-source-files'
  alias rsync-update='rsync -avzu --progress -h'
  alias rsync-synchronize='rsync -avzu --delete --progress -h'
fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
