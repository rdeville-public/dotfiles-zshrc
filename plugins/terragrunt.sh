#!/usr/bin/env bash

if command -v terragrunt >/dev/null; then
	alias tg="terragrunt"
	alias tga="terragrunt apply"
	alias tgf="terragrunt fmt"
	alias tgi="terragrunt init"
	alias tgo="terragrunt output"
	alias tgp="terragrunt plan"
	alias tgv="terragrunt validate"
	alias tgs="terragrunt state"
	alias tgssh="terragrunt state show"
	alias tgsh="terragrunt show"

  alias tgra="terragrunt run-all"
	alias tgraa="tgra apply"
	alias tgraf="tgra fmt"
	alias tgrai="tgra init"
	alias tgrao="tgra output"
	alias tgrap="tgra plan"
	alias tgrav="tgra validate"
	alias tgras="tgra state"
	alias tgrassh="tgra state show"
	alias tgrash="tgra show"

	complete -C "$(command -v terragrunt)" terragrunt
	complete -o nospace -C "$(command -v terragrunt)" terragrunt
fi
