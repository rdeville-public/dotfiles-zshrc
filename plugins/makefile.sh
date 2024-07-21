#!/usr/bin/env bash

if command -v make >/dev/null 2>&1; then
	# COMPLETION
	# ===========================================================================
	zstyle ':completion:*:make:*:variables' call-command false
	zstyle ':completion:*:make:*' tag-order targets variables
	zstyle ':completion:*:make:*' group-name ''
	zstyle ':completion:*:make:*:descriptions' format '%B%F3%d%b'
fi
