local wezterm = require 'wezterm'

local M = {}

M.setup_keys = function(c)
  c.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

  c.keys = {
    -- Raccourcis avec la combinaison leader
    { key = "t", mods = "LEADER", action = wezterm.action.SpawnTab "DefaultDomain" }, -- Ouvrir un nouvel onglet
    { key = "w", mods = "LEADER", action = wezterm.action.CloseCurrentTab { confirm = true } }, -- Fermer l'onglet actuel
    { key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) }, -- Onglet suivant
    { key = "p", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) }, -- Onglet précédent
  }
end

return M
