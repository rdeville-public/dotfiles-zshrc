#!/usr/bin/env bash

if command -v nvim >/dev/null 2>&1; then
	alias vim='nvim'
	alias v='vim'
	alias vd='vimdiff'
	alias svim='sudo vim'
	alias sv='sudo vim'
	alias vimdiff='nvim -d'
fi
