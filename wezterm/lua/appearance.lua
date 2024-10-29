local wez = require "wezterm"

local M = {}

M.apply_to_config = function(c)
  c.color_scheme = 'Catppuccin Mocha';
  c.window_background_opacity = 1
  c.inactive_pane_hsb = { brightness = 0.9 }
  c.window_padding = { left = "1cell", right = "1cell", top = 0, bottom = 0 }
  c.window_decorations = "TITLE | RESIZE"
  c.enable_tab_bar = true
end

return M
