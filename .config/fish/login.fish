#!/usr/bin/env fish

if test -f {$HOME}/.xinitrc
    if not set -q DISPLAY
        if test {$XDG_VTNR} -eq 1
            exec ssh-agent startx
        end
    end
end
