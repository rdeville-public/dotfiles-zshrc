#!/usr/bin/env bash

if command -v terraform >/dev/null; then
	alias tf="terraform"
	alias tfa="terraform apply"
	alias tfc="terraform console"
	alias tff="terraform fmt"
	alias tfi="terraform init"
	alias tfo="terraform output"
	alias tfp="terraform plan"
	alias tfv="terraform validate"
	alias tfs="terraform state"
	alias tfssh="terraform state show"
	alias tfsh="terraform show"
	alias tfw="terraform workspace"

	complete -C "$(command -v terraform)" terraform
	complete -o nospace -C "$(command -v terraform)" terraform
fi
