#!/usr/bin/env bash

alias sz="source ~/.zshrc"

# ls overload
if command -v lsd >/dev/null 2>&1; then
	# Append indicator at the end, show dir first, always show icons and show
	# human readable
	alias ls='lsd -F --group-dirs first --icon always -h'
else
	# Show colors, append indicator at the end, show dir first, show human
	# readable
	alias ls='ls --color=auto -F --group-directories-first -h -A'
fi
alias sl='ls'
alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'

# Utility
if command -v lsd >/dev/null 2>&1; then
	alias tree='ls --tree'
elif command -v tree >/dev/null 2>&1; then
	alias tree='tree -Cpsh --du --dirsfirst'
else
	alias tree='find . -print | sed -e "s;[^/]*/;|____;g;s;____|; |;g"'
fi
alias lt='tree'

# grep overload
alias grep='grep --color=auto'

# clear shortcut
alias c='clear'

# cd overload
alias cd..='cd ../'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias ~='cd ~'

# Dir and file manipulation (cp, mv, scp) to be interactive and verbose
alias mkdir='mkdir -p'
alias md='mkdir -p'
alias mv='mv -iv'
alias cp='cp -iv'
alias scp='scp -iv'
alias rm='rm -iv'

# sudo overload and utility
alias _='sudo'

# Clear all cache files and system
alias ccache='sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"'
