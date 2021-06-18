#!/usr/bin/env zsh

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

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

if [[ $TERM =~ '256color' ]]; then
    local blue="%F{12}"
    local orange="%F{11}"
    local purple="%F{13}"
    local red="%F{9}"
    local green="%F{10}"
    local gray="%F{7}"
else
    local blue="%{$fg[cyan]%}"
    local orange="%{$fg[yellow]%}"
    local purple="%{$fg[magenta]%}"
    local red="%{$fg[red]%}"
    local green="%{$fg[green]%}"
    local gray="%{$fg[white]%}"
fi

function parse_git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "${colon}${orange}${ref#refs/heads/}%f"
}

local lbrkt="${gray}[%f"
local rbrkt="${gray}]%f"
local colon="${gray}:%f"
local user="${purple}%n%f"
if [[ $LOCAL_SESSION -eq 1 ]]; then
    local host="${blue}%m%f"
    local prompt="%# "
else
    local host="${red}%m%f"
    local prompt="${red}%#%f "
fi
local dir="${green}%~%f"
local branch="\$(parse_git_branch)"
local exit_code="%(?..${red}%?%f)"

setopt prompt_subst
export PROMPT="${lbrkt}${user}${colon}${host}${colon}${dir}${branch}${rbrkt} ${exit_code}
${prompt}"

# aliases
source $HOME/.config/zsh/aliases

source $HOME/.config/zsh/z-zsh/z.sh
function precmd () {
    z --add "$(pwd -P)"
}

source $HOME/.config/zsh/j.sh

autoload -U select-word-style
select-word-style bash

which direnv > /dev/null && eval "$(direnv hook zsh)" || true

setopt interactivecomments

if [ -f "$HOME/.config/zsh/os.zshrc" ]; then
    source "$HOME/.config/zsh/os.zshrc"
fi
