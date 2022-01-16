#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/04.pipenv.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of pipenv completion and alias

if command -v pipenv > /dev/null 2>&1
then
  # ALIAS
  # ===========================================================================
  alias pich='pipenv check'
  alias picl='pipenv clean'
  alias pigr='pipenv graph'
  alias pi='pipenv install'
  alias pidev='pipenv install --dev'
  alias pil='pipenv lock'
  alias pio='pipenv open'
  alias pirun='pipenv run'
  alias pish='pipenv shell'
  alias pisy='pipenv sync'
  alias piu='pipenv uninstall'
  alias piwh='pipenv --where'
  alias ipvenv='pipenv --venv'
  alias pipy='pipenv --py'

  # COMPLETION
  # ===========================================================================
  source <(pipenv --completion)

fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
