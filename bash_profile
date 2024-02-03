#!/usr/bin/env bash

# Load the default .profile
if [[ -s "$HOME/.profile" ]]
then
  # shellcheck disable=1091
  source "$HOME/.profile"
fi

if [[ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]]
then
  # shellcheck disable=1091
  source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi
