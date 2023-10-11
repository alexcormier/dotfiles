#!/bin/sh

# xrandr \
#     --output DP-1 --primary --mode 2560x1440 --rate 120 \
#     --output HDMI-0 --right-of DP-1 --mode 2560x1440 --rate 60 \
#     --output DVI-D-0 --left-of DP-1 --mode 2560x1440 --rate 60

[ -f "${HOME}/.Xresources" ] && xrdb -merge "${HOME}/.Xresources"

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

~/.local/bin/switch_layout us

# start programs

redshift -l45.25:-75.41 &
xsetroot -cursor_name left_ptr
[[ -f ~/.fehbg ]] && ~/.fehbg
picom -b
parcellite -n &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

exec awesome
