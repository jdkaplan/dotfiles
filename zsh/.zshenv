export PATH=$PATH:$HOME/bin

export EDITOR='emacs'
export VISUAL=$EDITOR

export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

export XDG_CONFIG_HOME=$HOME/.config

if [ -n "$SSH_TTY" ] || [ -n "$SSH_CLIENT" ] || [ -n "$SSH_CONNECTION" ]; then
    LOCAL_SESSION=0
else
    LOCAL_SESSION=1
fi

export LOCAL_SESSION
