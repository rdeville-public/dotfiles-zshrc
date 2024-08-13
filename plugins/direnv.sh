#!/usr/bin/env bash

if command -v direnv >/dev/null 2>&1; then
	alias da="direnv allow"
	alias dr="direnv reload"
	alias ds="direnv status"

	# shellcheck disable=SC1090
	source <(direnv hook zsh)
fi
