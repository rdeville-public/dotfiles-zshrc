#!/usr/bin/env bash

ips() {
	# Show all IP of the computer
	if command -v ifconfig &>/dev/null; then
		echo "Your local IPs are:"
		ifconfig | awk '/inet /{ gsub(/addr:/, ""); print $2 }'
	elif command -v ip &>/dev/null; then
		echo "Your local IPs are:"
		ip addr | grep -oP --color=never 'inet \K[\d.]+' | xargs -I {} echo "  - {}"
	else
		echo "You don't have ifconfig or ip command installed!"
	fi

	# Get my public IP
	list=(
		"myip.dnsomatic.com"
		"checkip.dyndns.com"
		"checkip.dyndns.org"
	)

	for domain in "${list[@]}"; do
		if ping -q -c 1 "${domain}" &>/dev/null; then
			res=$(curl -s "https://${domain}" | grep -Eo '[0-9\.]+')
			echo "Your public IP is: ${res}"
			return
		fi
	done
}

bak() {
	# Make a bak of a file with a timestamp
	local filename
	local filetime

	filename=$1
	filetime=$(date +%Y-%m-%d_%H-%M-%S)

	mv "${filename}" "${filename}_${filetime}.bak"
}

sortcons() {
	# Sort connection state
	if ! command -v netstat &>/dev/null; then
	  echo "Command \`netstat\` not installed"
	  return 1
	fi

	netstat -nat | awk '{print $6}' | sort | uniq -c | sort -rn
}

man() {
	export LESS_TERMCAP_md=$'\e[01;31m'
	export LESS_TERMCAP_me=$'\e[0m'
	export LESS_TERMCAP_us=$'\e[01;32m'
	export LESS_TERMCAP_ue=$'\e[0m'
	export LESS_TERMCAP_so=$'\e[45;93m'
	export LESS_TERMCAP_se=$'\e[0m'

	command man "$@"
}
