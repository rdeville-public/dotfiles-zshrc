#!/usr/bin/env bash

# Forbid zsh to correct following command
alias cp='nocorrect cp'
alias gist='nocorrect gist'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias sudo='nocorrect sudo'
alias vim='nocorrect vim'

setopt correct
