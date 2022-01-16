#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/docker-compose.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of docker-compose alias

if command -v docker-compose > /dev/null 2>&1
then
  # ALIAS
  # ===========================================================================
  alias dco='docker-compose'
  alias dcob='docker-compose build'
  alias dcoe='docker-compose exec'
  alias dcops='docker-compose ps'
  alias dcorestart='docker-compose restart'
  alias dcorm='docker-compose rm'
  alias dcorun='docker-compose run'
  alias dcostop='docker-compose stop'
  alias dcoup='docker-compose up'
  alias dcodown='docker-compose down'
  alias dcopull='docker-compose pull'
  alias dcostart='docker-compose start'
  alias dcofresh='docker-compose-fresh'
  alias dcolog='docker-compose logs -f --tail 100'

##  # COMPLETION
##  # ===========================================================================
##  # shellcheck disable=SC1090
##  # - SC1090 : Can't follow non-constant source. Use a directive to specify location.
##  if [[ "${SHELL}" =~ bash ]]
##  then
##    source ${SHELL_DIR}/completion/docker_compose.bash
##  elif [[ "${SHELL}" =~ zsh ]]
##  then
##    source ${SHELL_DIR}/completion/docker_compose.zsh
##  fi

fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
