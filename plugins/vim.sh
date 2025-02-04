#!/usr/bin/env bash

if command -v nvim >/dev/null 2>&1; then
	alias vim='nvim'
	alias vimdiff='nvim -d'

	alias v='vim'
	alias vd='vimdiff'
	alias svim='sudo vim'
	alias sv='sudo vim'
fi
