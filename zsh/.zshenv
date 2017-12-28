export PATH=$HOME/bin:$HOME/.local/bin:$PATH

export EDITOR='nvim'
export VISUAL=$EDITOR

if [[ -a /usr/bin/virtualenvwrapper.sh ]]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/bin/virtualenvwrapper.sh
fi

export XDG_CONFIG_HOME=$HOME/.config

if [ -n "$SSH_TTY" ] || [ -n "$SSH_CLIENT" ] || [ -n "$SSH_CONNECTION" ]; then
    LOCAL_SESSION=0
else
    LOCAL_SESSION=1
fi

export LOCAL_SESSION

export SHELL=$(which zsh)
