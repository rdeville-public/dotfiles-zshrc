#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/ansible.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of alias for ansible and derivative ansible command

if command -v ansible > /dev/null 2>&1
then
  # ALIAS ====================================================================
  alias a='ansible'
  alias ap='ansible-playbook'
  alias adoc="ansible-doc"

fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
