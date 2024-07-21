#!/usr/bin/env bash

if command -v curl >/dev/null; then
	# Follow redirects
	alias cl='curl -L'
	# Follow redirects, download as original name
	alias clo='curl -L -O'
	# Follow redirects, download as original name, continue
	alias cloc='curl -L -C - -O'
	# Follow redirects, download as original name, continue, retry 5 times
	alias clocr='curl -L -C - -O --retry 5'
	# Follow redirects, fetch banner
	alias clb='curl -L -I'
	# See only response headers from a get request
	alias clhead='curl -D - -so /dev/null'
fi
