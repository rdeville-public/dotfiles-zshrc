#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/yum.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of alias for yum and derivative yum command

if command -v yum > /dev/null 2>&1
then
  # ALIAS
  # ===========================================================================
  # search package
  alias ys='yum search'
  # show package info
  alias yp='yum info'
  # list packages
  alias yl='yum list'
  # list package groups
  alias ygl='yum grouplist'
  # print all installed packages
  alias yli='yum list installed'
  # rebuilds the yum package list
  alias ymc='yum makecache'
  # upgrate packages
  alias yu='sudo yum update'
  # install package
  alias yi='sudo yum install'
  # install package group
  alias ygi='sudo yum groupinstall'
  # remove package
  alias yr='sudo yum remove'
  # remove pagage group
  alias ygr='sudo yum groupremove'
  # remove package and leaves
  alias yrl='sudo yum remove --remove-leaves'
  # clean cache
  alias yc='sudo yum clean all'
fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
