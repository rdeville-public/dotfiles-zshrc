#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/apt.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of alias for apt and derivative apt command

if command -v apt > /dev/null 2>&1
then
  # ALIAS
  # ===========================================================================
  if [[ "$(whoami)" == "root" ]]
  then
    # Install the provided package name
    alias aptinst='apt install -V'
    # Perform an update of the available packages
    alias aptupd='apt update'
    alias aptupg='apt upgrade && apt autoremove'
    # Clean useless package and remove temporary downloaded packages
    alias aptcl='apt autoremove && apt autoclean'
    # Remove specified package
    alias aptrm='apt remove'
    # Do a update of package list, upgrade package and clean temporary files
    alias fullupdate='aptupd && aptupg && aptcl'
  else
    # Install the provided package name
    alias aptinst='sudo apt install -V'
    # Perform an update of the available packages
    alias aptupd='sudo apt update'
    alias aptupg='sudo apt upgrade'
    alias aptdupg='sudo apt dist-upgrade'
    # Clean useless package and remove temporary downloaded packages
    alias aptcl='sudo apt autoremove && sudo apt autoclean'
    # Remove specified package
    alias aptrm='sudo apt remove'
    # Do a update of package list, upgrade package and clean temporary files
    alias fullupdate='aptupd && aptupg && aptdupg && aptcl'
  fi
  # Perform a text based research for package
  alias apts='apt-cache search'
  # List installed files for a packaged
  alias pkglsf='dpkg --listfiles'

fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
