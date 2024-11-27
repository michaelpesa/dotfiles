local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- Appearance settings
config.font = wezterm.font 'MesloLGS NF'
config.font_size = 12
config.color_scheme = 'Tokyo Night'
config.window_background_opacity = 0.85

-- Use ALT+SHIFT+bracket to move tabs
config.keys = {
  { key = '{', mods = 'SHIFT|ALT', action = wezterm.action.MoveTabRelative(-1) },
  { key = '}', mods = 'SHIFT|ALT', action = wezterm.action.MoveTabRelative(1) },
}

-- OS-specifc settings
local target = wezterm.target_triple
if string.find(target, 'linux') then
  config.enable_tab_bar = false
  config.window_decorations = 'NONE'
elseif string.find(target, 'apple') then
  config.window_decorations = 'RESIZE'
end

-- Host-specific settings
local hostname = wezterm.hostname()
if hostname == 'h510' then
  config.font_size = 10
  config.freetype_load_target = 'Light'
  config.freetype_render_target = 'HorizontalLcd'
end

return config
