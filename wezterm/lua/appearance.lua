local wez = require "wezterm"

local M = {}

M.apply_to_config = function(c)
  c.color_scheme_dirs = { "$HOME/.config/wezterm/colors" }

  c.color_scheme = 'Catppuccin Mocha';

  c.tab_bar_at_bottom = true;

  c.use_fancy_tab_bar = false;
  
  c.window_decorations = "RESIZE";
  
  c.window_background_opacity = 1;

  c.window_padding = { left = "1cell", right = "1cell", top = 0, bottom = 0 }
end

return M
