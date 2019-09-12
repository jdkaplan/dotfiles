#!/usr/bin/env zsh

if [ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then
    source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
