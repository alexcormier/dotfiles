local config = {}

config.terminal = os.getenv("TERMINAL") or "alacritty"
config.editor = os.getenv("EDITOR") or "vi"
config.editor_cmd = config.terminal .. " -e " .. config.editor
config.modkey = "Mod4"

return config
