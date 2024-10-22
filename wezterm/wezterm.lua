local wez = require "wezterm"
local utils = require "lua.utils"
local mappings = require "lua.mappings"
local appearance = require "lua.appearance"

local c = {}

if wez.config_builder then
  c = wez.config_builder()
end

-- General configurations
c.font = wez.font "JetBrainsMono Nerd Font"
c.font_size = 12
c.adjust_window_size_when_changing_font_size = false
c.audible_bell = "Disabled"
c.scrollback_lines = 3000
c.default_workspace = "main"
c.status_update_interval = 2000

-- appearance
appearance.apply_to_config(c)

-- keys
mappings.setup_keys(c)

return c
