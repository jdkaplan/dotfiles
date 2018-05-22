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
    local red="%F{196}"
    local green="%F{118}"
    local gray="%F{241}"
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
if [[ $LOCAL_SESSION -eq 1 ]]; then
    export PROMPT="${prompt}"
    export RPROMPT="${exit_code} ${lbrkt}${user}${colon}${host}${colon}${dir}${branch}${rbrkt}"
else
    export PROMPT="${lbrkt}${user}${colon}${host}${colon}${dir}${branch}${rbrkt} ${exit_code}
${prompt}"
    export RPROMPT=""
fi

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

which direnv > /dev/null && eval "$(direnv hook zsh)" || true
