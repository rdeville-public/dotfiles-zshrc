#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/general.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of general alias for linux

# METHOD
# =============================================================================
ips()
{
  # Show all IP of the computer
  if command -v ifconfig &>/dev/null
  then
    ifconfig | awk '/inet /{ gsub(/addr:/, ""); print $2 }'
  elif command -v ip &>/dev/null
  then
    ip addr | grep -oP 'inet \K[\d.]+'
  else
    echo "You don't have ifconfig or ip command installed!"
  fi
}

myip()
{
  # Get my public IP
  list=("http://myip.dnsomatic.com/"
        "http://checkip.dyndns.com/"
        "http://checkip.dyndns.org/")
  for url in ${list[*]}
  do
    if curl -s "${url}" > /dev/null 2>&1
    then
      break;
    fi
  done
  res=$(curl -s "${url}" | grep -Eo '[0-9\.]+')
  echo -e "${E_INFO}Your public IP is: ${E_BOLD}${res}${E_NORMAL}"
}

bak()
{
  # Make a bak of a file with a timestamp
  local filename
  local filetime
  filename=$1
  filetime=$(date +%Y-%m-%d_%H-%M-%S)
  cp -a "${filename}" "${filename}_${filetime}.bak"
}

del()
{
  # Create a .trash folder in /tmp and move $@ into this folder
  mkdir -p /tmp/.trash && mv -v "$@" /tmp/.trash;
}

psgrep()
{
  # shellcheck disable=SC2009
  # - SC2009: Consider using pgrep instead of grepping ps output
  ps aux | grep "${1:-.}" | grep -v grep
}

killit()
{
  # Kills any process that matches a regexp passed to it
  # shellcheck disable=SC2009
  # - SC2009: Consider using pgrep instead of grepping ps output
  ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs sudo kill
}

sortcons()
{
  # Sort connection state
  netstat -nat | awk '{print $6}' | sort | uniq -c | sort -rn
}

clrz()
{
  # Clear zombie processes
  # shellcheck disable=SC2216
  # - SC2216: Piping to 'kill', a command that doesn't read stdin. Wrong
  #           command or missing xargs?
  #
  ps -eal | awk '{ if ($2 == "Z") {print $4}}' | kill -9
}

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[45;93m' \
    LESS_TERMCAP_se=$'\e[0m' \

    command man "$@"
}

# ALIAS
# =============================================================================
# ls overload
if command -v lsd > /dev/null 2>&1
then
  # Append indicator at the end, show dir first, always show icons and show
  # human readable
  alias ls='lsd -F --group-dirs first --icon always -h'
elif ls --color -d . &> /dev/null 2>&1
then
  # Show colors, append indicator at the end, show dir first, show human
  # readable
  alias ls='ls --color=auto -F --group-directories-first -h -A'
elif ls -G -d . &> /dev/null 2>&1
then
  # Show colors, append indicator at the end, show dir first, show human
  # readable
  alias ls='ls -F -F --group-directories-first -h -A'
fi
alias sl='ls'
alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -al'
alias l1='ls -1'
# grep overload
alias grep='grep --color=auto'
# clear shortcut
alias c='clear'
alias k='clear'
alias cl='clear'
# cd overload
alias cd..='cd ../'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias ~='cd ~'
# mkdir and file manipulation (cp, mv, scp) overload to be interactive and
# verbose
alias mkdir='mkdir -p'
alias md='mkdir -p'
alias mv='mv -iv'
alias cp='cp -iv'
alias scp='scp -iv'
alias rm='rm -iv'
alias sc='shellcheck -x'

# Utility
if command -v tree > /dev/null 2>&1
then
  # Show dir first, report size of directory, turn on colors, print filetype
  # and permission, print file size, print in human readble
  alias tree='tree -Cpsh --du --dirsfirst'
else
  # Bare tree, without much information using find
  alias tree='find . -print | sed -e "s;[^/]*/;|____;g;s;____|; |;g"'

fi

# sudo overload and utility
alias _='sudo'

# Clear all cache files and system
alias ccache='sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"'


# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
