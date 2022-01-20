#!/usr/bin/env bash
# *****************************************************************************
# File    : ${SHELL_DIR}/plugin/01.git.sh
# License : GNU General Public License v3.0
# Author  : Romain Deville <contact@romaindeville.fr>
# *****************************************************************************

# DESCRIPTION:
# =============================================================================
# Set of git alias and method to ease git usage

if command -v git > /dev/null 2>&1
then
  # METHODS
  # ===========================================================================
  git_revert()
  {
    # Rever to previous commit
    git reset "$1"
    git reset --soft "HEAD@{1}"
    git commit -m "Revert to ${1}"
    git reset --hard
  }

  git_rollback()
  {
    # Rollback to a prevous git commit
    is_clean()
    {
      # Check if repo is clean
      if [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]]
      then
        echo -e "${E_WARNING}[WARNING] Your branch is dirty, please commit your changes.${E_NORMAL}"
        kill -INT $$
      fi
    }

    commit_exists()
    {
      # Check if commit to rollback exists
      git rev-list --quiet "$1"
      ret=$?
      if [ $ret -ne 0 ]
      then
        echo -e "${E_ERROR}[ERROR] Commit ${E_BOLD}${1}${E_ERROR} does not exist.${E_NORMAL}"
        kill -INT $$
      fi
    }

    keep_changes()
    {
      # Asking what to keep
      while true
      do
        echo -e "${E_INFO}[INFO] Do you want to keep all changes from rolled back revisions in your working tree? [Y/N]${E_NORMAL}"
        read -r RESP
        case $RESP in
          [yY])
            echo -e "${E_INFO}[INFO] Rolling back to commit ${E_BOLD}${1}${E_INFO} with unstaged changes.${E_NORMAL}"
            git reset "$1"
            break
            ;;
          [nN])
            echo -e "${E_INFO}[INFO] Rolling back to commit ${E_BOLD}${1}${E_INFO} with a clean working tree.${E_NORMAL}"
            git reset --hard "$1"
            break
            ;;
          *)
            echo -e "${E_ERROR}[ERROR] Please enter Y or N.${E_NORMAL}"
        esac
      done
    }

    if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]
    then
      is_clean
      commit_exists "$1"
      while true
      do
        echo -e "${E_WARNING}[WARNING] This will change your history and move the current HEAD back to commit ${E_BOLD}${1}.${E_NORMAL}"
        echo -e "${E_INFO}[INFO] Continue? [Y/N]${E_NORMAL}"
        read -r RESP
        case $RESP in
          [yY])
            keep_changes "$1"
            break
            ;;
          [nN])
            break
            ;;
          *)
            echo -e "${E_INFO}[INFO] Please enter Y or N.${E_NORMAL}"
        esac
      done
    else
      echo -e "${E_ERROR}[ERROR] You're currently not in a git repository.${E_NORMAL}"
    fi
  }

  git_info()
  {
    # get a quick overview for your git repo
    if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
        # print informations
        echo -e "${E_INFO}${E_BOLD} GIT REPO OVERVIEW ${E_NORMAL}"
        echo -e "${E_INF0}-------------------${E_NORMAL}"
        echo
        # print all remotes and thier details
        for remote in $(git remote show); do
            echo -e "${E_INFO}${E_BOLD}${remote}:${E_NORMAL}"
            git remote show "$remote"
            echo
        done
        # print status of working repo
        echo -e "${E_INFO}${E_BOLD}Status:${E_NORMAL}"
        if [ -n "$(git status -s 2> /dev/null)" ]; then
            git status -s
        else
            echo -e "${E_INFO}Working directory is clean${E_NORMAL}"
        fi
        # print at least 5 last log entries
        echo
        echo -e "${E_INFO}${E_BOLD}Log:${E_NORMAL}"
        git log -5 --oneline
        echo
    else
        echo "${E_WARNING}You're currently not in a git repository${E_NORMAL}"
    fi
  }

  git_stats()
  {
    # awesome work from https://github.com/esc/git-stats
    # including some modifications

    #test if the directory is a git
    if ! command -v git &> /dev/null
    then
        echo -e "${E_ERROR}[ERROR] Command git not installed${E_NORMAL}"
        return
    elif ! git branch &> /dev/null
    then
        echo -e "${E_ERROR}[ERROR] Not currently in a git repository${E_NORMAL}"
        return
    fi

    LOGOPTS=()
    END_AND_BEGIN=()
    #argument parsing
    while [ -n "$1" ]; do
        case "$1" in
         "-s")
            shift
            END_AND_BEGIN+=("--after=$1")
        ;;
        "-e")
            shift
            END_AND_BEGIN+=("--before=$1")
        ;;
        "-w")
            LOGOPTS+=("-w")
        ;;
        "-C")
            LOGOPTS+=("-C")
    		LOGOPTS+=("--find-copies-harder")
        ;;
        "-M")
            LOGOPTS+=("-M")
        ;;
        esac
        shift
    done
    echo -e "${E_INFO}${E_BOLD}Number of commits per author:${E_NORMAL}"
    git --no-pager shortlog "${END_AND_BEGIN[@]}" -sn --all
    AUTHORS=$(git shortlog "${END_AND_BEGIN[@]}" -sn --all | cut -f2 | tr "\n" ";" )
    if [[ ${SHELL} == bash ]]
    then
        IFS=';' read -ra AUTHORS <<< "${AUTHORS}"
    elif [[ ${SHELL} == zsh ]]
    then
        IFS=';' read -rA AUTHORS <<< "${AUTHORS}"
    fi
    for a in ${AUTHORS[@]}
    do
        echo -e "${E_BOLD}----------------------------${E_NORMAL}"
        echo -e "${E_INFO}Statistics for: ${E_BOLD}$a${E_NORMAL}"
        echo -e -n "${E_NORMAL}Number of files changed: ${E_INFO}"
        git log "${LOGOPTS[@]}" "${END_AND_BEGIN[@]}" --all --numstat \
          --format="%n" --author="$a" | grep -v -e "^$" | cut -f3 \
          | sort -iu | wc -l
        echo -e -n "${E_NORMAL}Number of lines added: ${E_INFO}"
        git log "${LOGOPTS[@]}" "${END_AND_BEGIN[@]}" --all --numstat \
          --format="%n" --author="$a" | cut -f1 | awk '{s+=$1} END {print s}'
        echo -e -n "${E_NORMAL}Number of lines deleted: ${E_INFO}"
        git log "${LOGOPTS[@]}" "${END_AND_BEGIN[@]}" --all --numstat \
          --format="%n" --author="$a" | cut -f2 | awk '{s+=$1} END {print s}'
        echo -e -n "${E_NORMAL}Number of merges: ${E_INFO}"
        git log "${LOGOPTS[@]}" "${END_AND_BEGIN[@]}" --all --merges \
          --author="$a" | grep -c '^commit'
        echo -e -n "${E_NORMAL}"
    done
  }

  gitignore_reload()
  {
    # The .gitignore file should not be reloaded if there are uncommited changes.
    # Firstly, require a clean work tree. The - name: require_clean_work_tree()
    # was stolen with love from https://www.spinics.net/lists/git/msg142043.html
    # Begin require_clean_work_tree()
    #
    # Update the index
    git update-index -q --ignore-submodules --refresh
    err=0

    # Disallow unstaged changes in the working tree
    if ! git diff-files --quiet --ignore-submodules --
    then
      echo >&2 "${E_ERROR}[ERROR] Cannot reload .gitignore: Your index contains unstaged changes.${E_NORMAL}"
      git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
      err=1
    fi

    # Disallow uncommited changes in the index
    if ! git diff-index --cached --quiet HEAD --ignore-submodules
    then
      echo >&2 "${E_ERROR}[ERROR] Cannot reload .gitignore: Your index contains uncommited changes."
      git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
      err=1
    fi

    # Prompt user to commit or stash changes and exit
    if [ $err = 1 ]
    then
      echo >&2 "${E_WARNING}[WARNING] Please commit or stash them.${E_NORMAL}"
    fi

    # End require_clean_work_tree()

    # If we're here, then there are no uncommited or unstaged changes dangling around.
    # Proceed to reload .gitignore
    if [ $err = 0 ]; then
      # Remove all cached files
      git rm -r --cached .

      # Re-add everything. The changed .gitignore will be picked up here and will exclude the files
      # now blacklisted by .gitignore
      echo >&2 "${E_INFO}[INFO] Running git add ."
      git add .
      echo >&2 "${E_INFO}[INFO] Files readded. Commit your new changes now."
    fi
  }

  gpat()
  {
    git push --all
    git push --tags
    if git config --get remote.upstream.url | grep -q 'rdeville.public'
    then
      git push upstream --all
      git push upstream --tags
    fi
  }

  # ALIAS
  # ===========================================================================
  if [[ "${OSTYPE}" =~ darwin* ]]
  then
    alias gtls='git tag -l | gsort -V'
  else
    alias gtls='git tag -l | sort -V'
  fi
  alias gcl='git clone'
  alias ga='git add'
  alias gap='git add -p'
  alias gall='git add -A'
  alias gai='git add --interactive'
  alias grm='git rm'
  alias gf='git fetch --all --prune'
  alias gft='git fetch --all --prune --tags'
  alias gfv='git fetch --all --prune --verbose'
  alias gftv='git fetch --all --prune --tags --verbose'
  alias gclean='git clean -fd'
  alias gm='git merge'
  alias gmv='git mv'
  alias g='git'
  alias get='git'
  alias gs='git status'
  alias gss='git status -s'
  alias gsu='git submodule update --init --recursive'
  alias gpl='git pull'
  alias glum='git pull upstream master'
  alias gpr='git pull --rebase'
  alias gpp='git pull && git push'
  alias gup='git fetch && git rebase'
  alias gp='git push'
  alias gr='git remote'
  alias grv='git remote -v'
  alias gra='git remote add'
  alias gd='git diff'
  alias gdt='git difftool'
  alias gds='git diff --staged'
  alias gc='git commit -v'
  alias gca='git commit -v -a'
  alias gci='git commit --interactive'
  alias gcount='git shortlog -sn'
  alias gco='git checkout'
  alias gcd='git checkout develop'
  alias gcb='git checkout -b'
  alias gct='git checkout --track'
  alias gexport='git archive --format zip --output'
  alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
  alias gll='git log --graph --pretty=oneline --abbrev-commit'
  alias gg='git log --graph --pretty=format:"%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset" --abbrev-commit --date=relative'
  alias ggs='gg --stat'
  alias gsl='git shortlog -sn'
  alias gwc='git whatchanged'
  alias gt='git tag'
  alias gpatch='git format-patch -1'
  alias gnew='git log HEAD@{1}..HEAD@{0}'
  alias gcaa='git commit -a --amend -C HEAD'
  alias gst='git stash'
  alias gstb='git stash branch'
  alias gstd='git stash drop'
  alias gstl='git stash list'
  alias gh='cd "$(git rev-parse --show-toplevel)"'
  alias gls='git ls-files . --exclude-standard'

fi

# *****************************************************************************
# EDITOR CONFIG
# vim: ft=sh: ts=2: sw=2: sts=2
# *****************************************************************************
