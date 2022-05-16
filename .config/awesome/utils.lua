local awful = require("awful")
local config = require("config")

function bind(func, ...)
    local args = table.pack(...)
    return function(...)
        local args2 = table.pack(...)
        for i = 1, args2.n do
            args[args.n + i] = args2[i]
        end
        args.n = args.n + args2.n
        return func(table.unpack(args, 1, args.n))
    end
end

function run_in_terminal(cmd)
    awful.spawn(config.terminal .. " -e " .. cmd)
end

function edit(path)
    awful.spawn(config.editor_cmd .. " " .. path)
end
