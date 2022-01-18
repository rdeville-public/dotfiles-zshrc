#!/usr/bin/env bash

if command -v fasd &> /dev/null
then
  mkdir -p "${SHELL_DIR}/cache/"
  case ${SHELL} in
    *bash)
      fasd_cache="${SHELL_DIR}/cache/fasd-init-bash"
      if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]
      then
        fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
      fi
      source "$fasd_cache"
      unset fasd_cache
      ;;
    *zsh)
      fasd_cache="${SHELL_DIR}/cache/fasd-init-zsh"
      if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]
      then
        fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >| "$fasd_cache"
      fi
      source "$fasd_cache"
      unset fasd_cache
      ;;
  esac
fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
