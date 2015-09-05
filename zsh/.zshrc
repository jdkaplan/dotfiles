# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/histfile
HISTSIZE=1000000
SAVEHIST=1000000
DIRSTACKSIZE=100
setopt appendhistory extendedglob nomatch
setopt autopushd pushdsilent pushdtohome histignorespace
unsetopt beep autocd notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle ':completion:*' _expand completer _complete _ignored
zstyle ':completion:*' matcher-list '' 'l:|=* r:|=*' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# prompt
autoload -U colors
colors

autoload -U zmv
alias mmv='noglob zmv -W'

if [[ $TERM =~ '256color' ]]; then
    local blue="%F{81}"
    local orange="%F{166}"
    local purple="%F{135}"
    local hotpink="%F{161}"
    local green="%F{118}"
    local gray="%F{241}"
else
    local blue="%{$fg[cyan]%}"
    local orange="%{$fg[yellow]%}"
    local purple="%{$fg[magenta]%}"
    local hotpink="%{$fg[red]%}"
    local gray="%{$fg[white]%}"
fi

local lbrkt="${gray}[%f"
local rbrkt="${gray}]%f"
local colon="${gray}:%f"
local user="${purple}%n%f"
local host="${blue}%m%f"
local dir="${green}%~%f"

export PROMPT="%# "
export RPROMPT="${lbrkt}${user}${colon}${host}${colon}${dir}${rbrkt}"

# aliases
source $HOME/.config/zsh/aliases

source $HOME/.config/zsh/z-zsh/z.sh
function precmd () {
    z --add "$(pwd -P)"
}

# ls colors
eval $(dircolors $HOME/.config/zsh/dircolors.256dark)

autoload -U select-word-style
select-word-style bash

export PATH=$PATH:$HOME/bin

[ -f ~/.profile ] && source ~/.profile
