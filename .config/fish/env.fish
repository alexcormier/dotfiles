#!/usr/bin/env fish

# path
set -g fish_user_paths {$HOME}/.local/bin
test -d {$HOME}/.cargo/bin; and set -a fish_user_paths {$HOME}/.cargo/bin
command -q go; and test -d (go env GOPATH); and set -a fish_user_paths (go env GOPATH)/bin
 
# standard programs
command -q alacritty; and set -gx TERMINAL 'alacritty'
command -q bat; and set -gx MANPAGER 'sh -c "col -bx | bat -l man -p"'
command -q firefox; and set -gx BROWSER 'firefox'

# editor
if command -q nvim
    set -gx EDITOR 'nvim'
else if command -q vim
    set -gx EDITOR 'vim'
else
    set -gx EDITOR 'vi'
end

# misc
set -gx npm_config_prefix {$HOME}/.local
set -gx IDF_PATH /opt/esp-idf
