#!/usr/bin/env bash

if command -v docker >/dev/null; then
	if [[ ${OSTYPE} =~ (darwin.*|.*bsd.*|.*BSD.*) ]]; then
		# Delete all untagged Docker images
		alias dkrmui='docker images -q -f dangling=true | xargs docker rmi'
	else
		# Delete all untagged Docker images
		alias dkrmui='docker images -q -f dangling=true | xargs -r docker rmi'
	fi
	alias dk='docker'
	alias dklcid='docker ps -l -q'
	alias dkps='docker ps'
	alias dkpsa='docker ps -a'
	alias dki='docker images'
	alias dkrmall='docker rm $(docker ps -a -q)'
	alias dkrm='docker rm'
	alias dkrmiall='docker rmi $(docker images -q)'
	alias dkrmi='docker rmi'
	alias dkex='docker exec -it'
	alias dkri='docker run --rm -i'
	alias dkrit='docker run --rm -it'
	alias dkip='docker image prune -a -f'
	alias dkvp='docker volume prune -f'
	alias dksp='docker system prune -a -f'
fi
