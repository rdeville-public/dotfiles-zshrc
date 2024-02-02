#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/terraform.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of tmux alias
#
if command -v terraform > /dev/null
then
  alias tf="terraform"
  alias tfa="terraform apply"
  alias tfc="terraform console"
  alias tfd="terraform destroy"
  alias tff="terraform fmt"
  alias tfi="terraform init"
  alias tfo="terraform output"
  alias tfp="terraform plan"
  alias tfv="terraform validate"
  alias tfs="terraform state"
  alias tfsh="terraform show"
  alias tfw="terraform workspace"
fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************