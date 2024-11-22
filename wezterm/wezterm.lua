local wez = require "wezterm"
local c = {}

if wez.config_builder then
  c = wez.config_builder()
end

-- Appearance
c.font = wez.font "JetBrainsMono Nerd Font"
c.font_size = 13
c.color_scheme = "Catppuccin Mocha"
c.window_background_opacity = 0.9
c.inactive_pane_hsb = { brightness = 0.9 }
c.window_padding = { left = "1cell", right = "1cell", top = 0, bottom = 0 }
c.window_decorations = "NONE"
c.enable_tab_bar = false

-- General config
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.scrollback_lines = 3000
c.default_workspace = "main"
c.status_update_interval = 2000

return c
