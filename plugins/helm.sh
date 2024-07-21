#!/usr/bin/env bash

if command -v helm >/dev/null 2>&1; then
	alias h='helm'

	# shellcheck disable=SC1090
	source <(helm completion zsh)
fi
