#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

if [ -f "${HOME}/.xsessionrc" ] ; then
    . "${HOME}/.xsessionrc"
fi

exec i3
