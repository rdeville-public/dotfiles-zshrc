#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/docker.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of docker alias, command and completion

if command -v docker > /dev/null
then
  # METHOD
  # ===========================================================================
  docker_remove_most_recent_container()
  {
    docker ps -ql | xargs docker rm
  }

  docker_remove_most_recent_image()
  {
    docker images -q | head -1 | xargs docker rmi
  }

  docker_remove_stale_assets()
  {
    docker ps --filter status=exited -q | xargs docker rm --volumes
    docker images --filter dangling=true -q | xargs docker rmi
  }

  docker_enter()
  {
    docker exec -it "$@" /bin/bash
  }

  docker_cleanup(){
    docker rm $(docker ps -a -q)
    docker rmi $(docker images -q)
  }

  docker_remove_images()
  {
    if [ -z "$1" ]; then
      docker rmi "$(docker images -q)"
    else
      DOCKER_IMAGES=""
      for IMAGE_ID in "$@"
      do
        DOCKER_IMAGES="$DOCKER_IMAGES\|$IMAGE_ID"
      done
      # Find the image IDs for the supplied tags
      echo "docker images | grep ${DOCKER_IMAGES:2} | awk 'print $3'"
      # Strip out duplicate IDs before attempting to remove the image(s)
      docker rmi "$(echo "${ID_ARRAY[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')"
    fi
  }

  docker_image_dependencies()
  {
    if hash dot 2>/dev/null; then
      OUT=$(mktemp -t docker-viz-XXXX.png)
      docker images -viz | dot -Tpng > "$OUT"
      case $OSTYPE in
        linux*)
          xdg-open "$OUT"
          ;;
        darwin*)
          open "$OUT"
          ;;
      esac
    else
      >&2 echo "${E_ERROR}[ERROR] Can't show dependencies; Graphiz is not installed${E_NORMAL}"
    fi
  }

  docker_runtime_environment()
  {
    docker run "$@" env
  }

  docker_archive_content()
  {
    if [ -n "$1" ]; then
      tar -xzOf "$1" manifest.json | jq '[.[] | .RepoTags] | add'
    fi
  }


  # ALIAS
  # ===========================================================================
  if [[ ${OSTYPE} =~ (darwin.*|.*bsd.*|.*BSD.*) ]]
  then
    # Delete all untagged Docker images
    alias dkrmui='docker images -q -f dangling=true | xargs docker rmi'
  else
    # Delete all untagged Docker images
    alias dkrmui='docker images -q -f dangling=true | xargs -r docker rmi'
  fi
  # Call docker command
  alias dk='docker'
  # List last Docker container
  alias dklc='docker ps -l'
  # List last Docker container ID
  alias dklcid='docker ps -l -q'
  # Get IP of last Docker container
  alias dklcip='docker inspect -f "{{.NetworkSettings.IPAddress}}" $(docker ps -l -q)'
  # List running Docker containers
  alias dkps='docker ps'
  # List all Docker containers
  alias dkpsa='docker ps -a'
  # List Docker images
  alias dki='docker images'
  # Delete all Docker containers
  alias dkrmall='docker rm $(docker ps -a -q)'
  # Delete most recent (i.e., last) Docker container
  alias dkrmlc='docker_remove_most_recent_container'
  # Delete all untagged images and exited containers
  alias dkrmall='docker_remove_stale_assets'
  # Delete most recent (i.e., last) Docker image
  alias dkrmli='docker_remove_most_recent_image'
  # Delete images for supplied IDs or all if no IDs are passed as arguments
  alias dkrmi='docker_remove_images'
  # Output a graph of image dependencies using Graphiz
  alias dkideps='docker_image_dependencies'
  # List environmental variables of the supplied image ID
  alias dkre='docker_runtime_environment'
  # Enter last container (works with Docker 1.3 and above)
  alias dkelc='docker exec -it $(dklcid) bash --login'
  alias dkrmflast='docker rm -f $(dklcid)'
  alias dkbash='dkelc'
  # Useful to run any commands into container without leaving host
  alias dkex='docker exec -it'
  alias dkri='docker run --rm -i'
  alias dkrit='docker run --rm -it'
  # Added more recent cleanup options from newer docker versions
  alias dkip='docker image prune -a -f'
  # Added more recent cleanup options from newer docker versions
  alias dkvp='docker volume prune -f'
  # Added more recent cleanup options from newer docker versions
  alias dksp='docker system prune -a -f'

##  # COMPLETION
##  # ===========================================================================
##  # shellcheck disable=SC1090,SC1009
##  # - SC1090 : Can't follow non-constant source. Use a directive to specify location.
##  # - SC1009: The mentioned syntax error was in this if expression.
##  if [[ "${SHELL}" =~ bash ]]
##  then
##    source ${SHELL_DIR}/completion/docker_completion.bash
##  elif [[ "${SHELL}" =~ zsh ]]
##  then
##    source ${SHELL_DIR}/completion/docker_completion.zsh
##  fi

fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
