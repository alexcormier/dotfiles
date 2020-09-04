: ${ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim}

if command -v bat > /dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

if command -v alacritty > /dev/null 2>&1; then
    export TERM='alacritty'
    export TERMINAL="${TERM}"
fi
command -v vim > /dev/null 2>&1 && export EDITOR='nvim'

path=("${HOME}/.local/bin" $path)

[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

