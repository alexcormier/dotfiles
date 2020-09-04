#!/usr/bin/env fish

if test -f {$HOME}/.xinitrc -a -z {$DISPLAY} -a {$XDG_VTNR} -eq 1
    exec ssh-agent startx
end
