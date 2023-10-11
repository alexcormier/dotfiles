#!/usr/bin/env fish

# manage dotfiles
alias dots 'git --git-dir {$HOME}/.config/dots --work-tree {$HOME}'

# shorthands for ls
alias l ls
alias la 'ls -a'
alias ll 'ls -l'
alias lla 'ls -la'
alias llaa 'ls -laa' # specific to exa, equivalent to -la with ls proper

# create parent directories by default
alias mkdir 'mkdir -p'

# prevent accidental overwrites and deletions
alias cp 'cp -i'
alias mv 'mv -i'
alias rm 'rm -I'

# resume downloads by default
command -q wget && alias wget 'wget -c'

# replace some programs
command -q eza && alias ls 'eza --classify --git'
command -q bat && alias cat bat
command -q yay && alias pacman yay

# always use the preferred vi variant
for ed in vi vim nvim
    test "$EDITOR" != "$ed" && alias "$ed" "$EDITOR"
end
