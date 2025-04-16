local wezterm = require('wezterm')
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 12.0

-- No tab bar
config.enable_tab_bar = false

-- Window appearance
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 20,
  right = 20,
  top = 20,
  bottom = 20,
}
config.window_background_opacity = 0.9

-- Theme
config.color_scheme = "Catppuccin Mocha"

-- Keyboard shortcuts
config.keys = {
  -- Font size
  {
    key = '+',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.IncreaseFontSize,
  },
  {
    key = '-',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DecreaseFontSize,
  },
  {
    key = 'Backspace',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ResetFontSize,
  },
}

return config 
