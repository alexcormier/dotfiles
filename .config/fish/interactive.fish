#!/usr/bin/env fish

for file in {$FISH_CONFIG_HOME}/interactive.d/*.fish
    source {$file}
end
