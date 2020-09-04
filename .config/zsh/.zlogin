source ${ZIM_HOME}/login_init.zsh -q &!

[[ -f ~/.xinitrc && -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec ssh-agent startx
