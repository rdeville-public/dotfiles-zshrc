#!/usr/bin/env bash

if command -v docker-compose >/dev/null 2>&1; then
	alias dco='docker-compose'
	alias dcob='docker-compose build'
	alias dcoe='docker-compose exec'
	alias dcops='docker-compose ps'
	alias dcorestart='docker-compose restart'
	alias dcorm='docker-compose rm'
	alias dcorun='docker-compose run'
	alias dcostop='docker-compose stop'
	alias dcoup='docker-compose up'
	alias dcodown='docker-compose down'
	alias dcopull='docker-compose pull'
	alias dcostart='docker-compose start'
	alias dcofresh='docker-compose-fresh'
	alias dcolog='docker-compose logs -f --tail 100'
fi
