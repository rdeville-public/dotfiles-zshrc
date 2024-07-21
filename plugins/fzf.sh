#!/usr/bin/env bash

if command -v fzf &>/dev/null; then
	export FZF_DEFAULT_OPTS="\
  --preview-window right:60% \
  --layout reverse \
  --margin=1,4 \
  --preview 'bat --color=always --style=numbers --line-range=:500 {}'"

fi
