#!/usr/bin/env zsh

PROMPT="precmd"

autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

zsh_syntax_highlighting=(
  "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)

zsh_autosuggestion=(
  "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
)

for i_zsh_plugin in "zsh_autosuggestion" "zsh_syntax_highlighting"
do
  array=(${(P)i_zsh_plugin})
  sourced="false"
  for j_plug_file in "${array[@]}"
  do
    if [[ -e "${j_plug_file}" ]]
    then
      sourced="true"
      source "${j_plug_file}"
    fi
  done
  if [[ "${sourced}" == "false" ]]
  then
    echo "Missing file: ${i_zsh_plugin//_/ }"
  fi
done

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] \
  && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# Move zcompdump file (i.e. autocompletion cache for zsh)
compinit -d "${HOME}/.cache/zsh/zcompdump-$ZSH_VERSION"

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
