#!/usr/bin/env fish

# manage dotfiles
alias dots 'git --git-dir {$HOME}/.config/dots --work-tree {$HOME}'

# shorthands for ls
alias l 'ls'
alias la 'ls -a'
alias ll 'ls -l'
alias lla 'ls -la'
alias llaa 'ls -laa' # specific to exa, equivalent to -la with ls proper

# create parent directories by default
alias mkdir 'mkdir -p'

# prevent accidental overwrites
alias cp 'cp -i'
alias mv 'mv -i'

# resume downloads by default
command -q wget && alias wget 'wget -c'

# replace some programs
command -q exa && alias ls 'exa --classify --git'
command -q bat && alias cat 'bat'
command -q yay && alias pacman 'yay'
command -q vim && alias vi 'vim'
command -q nvim && alias vim 'nvim'
