#!/usr/bin/env bash

if command -v neomutt > /dev/null
then
  alias m="neomutt"
elif command -v mutt > /dev/null
then
  alias m="mutt"
fi