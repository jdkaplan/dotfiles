#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xset -b
xset -dpms
xset s off
xset s 0 0
xset r rate 250

xsetroot -cursor_name left_ptr

setxkbmap -layout us,us -variant dvorak, -option grp:ctrls_toggle,shift:both_capslock,caps:escape,compose:prsc

exec i3
