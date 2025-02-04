#!/usr/bin/env bash

if command -v git >/dev/null 2>&1; then
  # METHODS
  # ===========================================================================
  gpat() {
    git push --all
    git push --tags
    if git config --get remote.upstream.url | grep -q 'rdeville.public'; then
      git push upstream --all
      git push upstream --tags
    fi
  }

  gco() {
    local curr_branch
    local stash_msg
    local stash_idx

    curr_branch=$(git rev-parse --abbrev-ref HEAD)
    stash_msg="Autostash branch ${curr_branch} before checkout"

    git stash push -m "${stash_msg}"
    git checkout "$@"

    curr_branch=$(git rev-parse --abbrev-ref HEAD)
    stash_msg="Autostash branch ${curr_branch} before checkout"
    if git stash list | grep -q "${stash_msg}"; then
      echo "Unstash previous autostash"
      stash_idx="$(git stash list | grep "${stash_msg}" | sed "s/.*@{\(.*\)}:.*${curr_branch/\//\\/}.*${stash_msg/\//\\/}/\1/")"
      git stash pop "${stash_idx}"
    fi
  }

  gcb() {
    gco -b "$@"
  }

  # ALIAS
  # ===========================================================================
  if [[ "${OSTYPE}" =~ darwin* ]]; then
    alias gtls='git tag -l | gsort -V'
  else
    alias gtls='git tag -l | sort -V'
  fi
  alias gcl='git clone'
  alias ga='git add'
  alias gap='git add -p'
  alias gai='git add --interactive'
  alias grm='git rm'
  alias gf='git fetch --all --prune'
  alias gft='git fetch --all --prune --tags'
  alias gfv='git fetch --all --prune --verbose'
  alias gftv='git fetch --all --prune --tags --verbose'
  alias gclean='git clean -fd'
  alias gmv='git mv'
  alias g='git'
  alias get='git'
  alias gs='git status'
  alias gss='git status -s'
  alias gpl='git pull'
  alias gup='git fetch && git rebase'
  alias gp='git push'
  alias gpf='git push --force-with-lease'
  alias gr='git remote -v'
  alias gra='git remote add'
  alias gd='git diff'
  alias gdt='git difftool'
  alias gds='git diff --staged'
  alias gc='git commit -v'
  alias gca='git commit -v --amend'
  alias gct='git checkout --track'
  alias gll='git log --graph --pretty=oneline --abbrev-commit'
  alias gg='git log --graph --pretty=format:"%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset" --abbrev-commit --date=relative'
  alias ggs='gg --stat'
  alias gt='git tag'
  alias gnew='git log HEAD@{1}..HEAD@{0}'
  alias gst='git stash'
  alias gstb='git stash branch'
  alias gstd='git stash drop'
  alias gstl='git stash list'
  alias gls='git ls-files . --exclude-standard'
fi
