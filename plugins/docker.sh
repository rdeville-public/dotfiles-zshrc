#!/usr/bin/env bash

if command -v docker >/dev/null; then
	if [[ ${OSTYPE} =~ (darwin.*|.*bsd.*|.*BSD.*) ]]; then
		# Delete all untagged Docker images
		alias dkrmui='docker images -q -f dangling=true | xargs docker rmi'
	else
		# Delete all untagged Docker images
		alias dkrmui='docker images -q -f dangling=true | xargs -r docker rmi'
	fi
	# Call docker command
	alias dk='docker'
	# List last Docker container ID
	alias dklcid='docker ps -l -q'
	# List running Docker containers
	alias dkps='docker ps'
	# List all Docker containers
	alias dkpsa='docker ps -a'
	# List Docker images
	alias dki='docker images'
	# Delete all Docker containers
	alias dkrmall='docker rm $(docker ps -a -q)'
	alias dkrmflast='docker rm -f $(dklcid)'
	alias dkrm='docker rm'
	# Delete most recent (i.e., last) Docker image
	alias dkrmiall='docker rmi $(docker images -q)'
	alias dkrmi='docker rmi'
	# Enter last container (works with Docker 1.3 and above)
	alias dkelc='docker exec -it $(dklcid) bash --login'
	alias dkbash='dkelc'
	# Useful to run any commands into container without leaving host
	alias dkex='docker exec -it'
	alias dkri='docker run --rm -i'
	alias dkrit='docker run --rm -it'
	# Added more recent cleanup options from newer docker versions
	alias dkip='docker image prune -a -f'
	# Added more recent cleanup options from newer docker versions
	alias dkvp='docker volume prune -f'
	# Added more recent cleanup options from newer docker versions
	alias dksp='docker system prune -a -f'
fi
