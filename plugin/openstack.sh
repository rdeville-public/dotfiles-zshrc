#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/openstack.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of openstack completion

if command -v openstack > /dev/null 2>&1
then
  # COMPLETION
  # ===========================================================================
#  if [[ "${SHELL}" =~ bash ]]
#  then
#    source <(openstack complete)
#  fi
#
  # ALIAS
  # ===========================================================================
  alias os="openstack"
  alias oss="openstack server"
  alias ossl="openstack server list"
  alias ossd="openstack server delete"
  alias osfl="openstack flavor list"
  alias osvl="openstack volume list"
  alias osvd="openstack volume delete"
  alias osil="openstack image list"
  alias osnl="openstack network list"
fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
