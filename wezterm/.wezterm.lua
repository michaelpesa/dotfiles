local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- Appearance settings
config.term = 'wezterm'
config.font = wezterm.font 'MesloLGS NF'
config.font_size = 12
config.color_scheme = 'Tokyo Night'
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.85

return config
