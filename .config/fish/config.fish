#!/usr/bin/env fish

set -l FISH_CONFIG_HOME {$HOME}/.config/fish
if set -q XDG_CONFIG_HOME
    set FISH_CONFIG_HOME {$XDG_CONFIG_HOME}/fish
end

set -l login_file {$FISH_CONFIG_HOME}/login.fish
set -l env_file {$FISH_CONFIG_HOME}/env.fish
set -l interactive_file {$FISH_CONFIG_HOME}/interactive.fish
set -l logout_file {$FISH_CONFIG_HOME}/logout.fish

if status is-login; and test -f {$login_file}
    source {$login_file}
end

if test -f {$env_file}
    source {$env_file}
end

if status is-interactive; and test -f {$interactive_file}
    source {$interactive_file}
end

function on_exit --on-event fish_exit
    if status --is-login; and test -f {$logout_file}
        source {$logout_file}
    end
end
