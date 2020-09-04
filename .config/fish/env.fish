#!/usr/bin/env fish

command -q alacritty; and set -gx TERMINAL 'alacritty'
command -q bat; and set -gx MANPAGER 'sh -c "col -bx | bat -l man -p"'
command -q firefox; and set -gx BROWSER 'firefox'

if command -q nvim
    set -gx EDITOR 'nvim'
else if command -q vim
    set -gx EDITOR 'vim'
else
    set -gx EDITOR 'vi'
end

set -g fish_user_paths {$HOME}/.local/bin
test -d {$HOME}/.cargo/bin; and set -a fish_user_paths {$HOME}/.cargo/bin
