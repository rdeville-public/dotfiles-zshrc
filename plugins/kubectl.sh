#!/usr/bin/env bash

if command -v kubectl >/dev/null 2>&1; then
	# ALIAS
	# ===========================================================================
	# This command is used a LOT both below and in daily life
	alias k='kubectl'
	# Apply a YML file
	alias kaf='kubectl apply -f'
	alias kak='kubectl apply -k'
	# into an interactive terminal on a container
	alias keti='kubectl exec -ti'
	# Shortcuts
	alias kg='kubectl get'
	alias kd='kubectl describe'
	# Pod management.
	alias kgp='kubectl get pods'
	alias kgpw='kgp --watch'
	alias kgpwide='kgp -o wide'
	alias kdp='kubectl describe pods'
	# Service management.
	alias kgs='kubectl get svc'
	alias kgsw='kgs --watch'
	alias kgswide='kgs -o wide'
	alias kds='kubectl describe svc'
	# Ingress management
	alias kgi='kubectl get ingress'
	alias kdi='kubectl describe ingress'
	# Namespace management
	alias kgns='kubectl get namespaces'
	alias kdns='kubectl describe namespace'
	# ConfigMap management
	alias kgcm='kubectl get configmaps'
	alias kdcm='kubectl describe configmap'
	# Secret management
	alias kgsec='kubectl get secret'
	alias kdsec='kubectl describe secret'
	# Deployment management.
	alias kgd='kubectl get deployment'
	alias kgdw='kgd --watch'
	alias kgdwide='kgd -o wide'
	alias kdd='kubectl describe deployment'
	alias krsd='kubectl rollout status deployment'
	alias krrd='kubectl rollout restart deployment'
	# Rollout management.
	alias kgrs='kubectl get rs'
	# Port forwarding
	alias kpf='kubectl port-forward'
	# Tools for accessing all information
	alias kga='kubectl get all'
	alias kgaa='kubectl get all --all-namespaces'
	# Logs
	alias kl='kubectl logs'
	alias klf='kubectl logs -f'
	# Node Management
	alias kgno='kubectl get nodes'
	alias kdno='kubectl describe node'

	# shellcheck disable=SC1090
	source <(kubectl completion zsh)
fi
