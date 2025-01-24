local wezterm = require 'wezterm'
local config = {}
config.font = wezterm.font 'JetBrains Mono'
config.audible_bell = "Disabled"
config.automatically_reload_config = true
return config