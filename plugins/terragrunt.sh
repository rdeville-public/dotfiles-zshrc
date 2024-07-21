#!/usr/bin/env bash

if command -v terragrunt >/dev/null; then
	alias tg="terragrunt"
	alias tga="terragrunt apply"
	alias tgc="terragrunt console"
	alias tgf="terragrunt fmt"
	alias tgi="terragrunt init"
	alias tgo="terragrunt output"
	alias tgp="terragrunt plan"
	alias tgv="terragrunt validate"
	alias tgs="terragrunt state"
	alias tgssh="terragrunt state show"
	alias tgsh="terragrunt show"
	alias tgw="terragrunt workspace"

	complete -C "$(command -v terragrunt)" terragrunt
	complete -o nospace -C "$(command -v terragrunt)" terragrunt
fi
