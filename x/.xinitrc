#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?* ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

main="eDP1"
previous="$main"
mainres="$(xrandr --query | grep -A 1 $main | sed --quiet -E 's/^\s+([0-9]+)x.*$/\1/p')"
for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [ "$m" != "$main" ]; then
        res="$(xrandr --query | grep -A 1 $m | sed --quiet -E 's/^\s+([0-9]+)x.*$/\1/p')"
        scale="$(echo "scale=1;$mainres/$res" | bc)"
        xrandr --output $m --right-of $previous --scale $scale
        previous=$m
    fi
done

# start programs

xflux -l 46.7 -g -71.3
xsetroot -cursor_name left_ptr
# [[ -f ~/.fehbg ]] && ~/.fehbg
nitrogen --restore
picom -b
parcellite -n &

TERMINAL="alacritty" exec bspwm
