local wezterm = require('wezterm')
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'One Dark (Gogh)'

config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 12.0

-- No tab bar
config.enable_tab_bar = true

-- Window appearance
config.window_decorations = "TITLE | RESIZE"
config.window_background_opacity = 1

return config 
