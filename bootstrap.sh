#!/usr/bin/env bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

declare -A NODES

NODES["${SCRIPTPATH}/shellrc"]="${HOME}/.bashrc"
NODES["${SCRIPTPATH}/shellrc"]="${HOME}/.zshrc"

source "${SCRIPTPATH}/lib/_shell_log.sh"

for i_node in "${!NODES[@]}"
do
  src="${i_node}"
  dest="${NODES[${i_node}]}"

  if ! [[ -d "$(dirname "${dest}")" ]]
  then
    mkdir -p "$(dirname "${dest}")"
  fi

  if ! [[ -e "${src}" ]]
  then
    mr_log "WARNING" "Bootstrap: Symlink source **${src/${HOME}/\~}** does not exists."
    mr_log "WARNING" "Bootstrap: Will create symlink anyway as you may setup source later."
  fi

  if [[ -e "${dest}" ]] && ! [[ -L "${dest}" ]]
  then
    mr_log "INFO" "Bootstrap: File **${dest/${HOME}/\~}** is not a symlink."
    mr_log "INFO" "Bootstrap: Backup file **${dest/${HOME}/\~}**."
    ln -s "${src}" "${dest}"
  fi
  if ! [[ -e "${dest}" ]]
  then
    mr_log "INFO" "Bootstrap: Create symlink to **${dest/${HOME}/\~}**."
    ln -s "${src}" "${dest}"
  else
    mr_log "INFO" "Bootstrap: Symlink to **${dest/${HOME}/\~}** already exists."
  fi
done
