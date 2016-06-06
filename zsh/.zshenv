export PATH=$PATH:$HOME/bin

export EDITOR='emacs'
export VISUAL=$EDITOR

export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

export XDG_CONFIG_HOME=$HOME/.config

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_CLIENT" ] || [ -n "$SSH_CLIENT" ]; then
    SHELL_TYPE='remote/ssh'
else
    SHELL_TYPE='local'
fi

export SHELL_TYPE
