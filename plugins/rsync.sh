#!/usr/bin/env bash

if command -v rsync >/dev/null 2>&1; then
	alias rsync='rsync -avz --progress -h'
fi
