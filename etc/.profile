export EDITOR='emacs'
export VISUAL=$EDITOR

export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

export XDG_CONFIG_HOME=$HOME/.config

PANEL_CONFIG_DIR=$XDG_CONFIG_HOME/panel
PANEL_FIFO=/tmp/panel-fifo
PANEL_HEIGHT=24
PANEL_FONT_FAMILY="-*-terminus-medium-r-normal-*-12-*-*-*-c-*-*-1"
export PANEL_FIFO PANEL_HEIGHT PANEL_FONT_FAMILY PANEL_CONFIG_DIR
