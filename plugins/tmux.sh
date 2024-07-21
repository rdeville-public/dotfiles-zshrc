#!/usr/bin/env bash

if command -v tmux >/dev/null; then
	alias ta='tmux attach -t'
	alias ts='tmux switch-client -t'
	alias tls='tmux list-sessions'
	alias tksv='tmux kill-server'
	alias tkss='tmux kill-session -t'

	if command -v tmuxp &>/dev/null; then
		alias tl="tmuxp load -y"
		alias tld="tmuxp load -y \${TMUXP_CONFIG:-default}"
	fi
fi
