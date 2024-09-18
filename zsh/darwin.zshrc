#!/usr/bin/env zsh

alias ls='ls --color=auto'
export LSCOLORS='Exgxbxdxcxegedabagacad'

alias units='gunits --verbose'

source ~/.profile

[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && source "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
