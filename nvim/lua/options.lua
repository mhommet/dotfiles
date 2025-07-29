require "nvchad.options"

-- Options personnalisées
local o = vim.o

-- Performance
o.timeoutlen = 300         -- Temps d'attente pour les combinaisons de touches
o.updatetime = 250         -- Temps de mise à jour pour les diagnostics
o.redrawtime = 10000       -- Plus de temps pour les gros fichiers

-- Interface
o.scrolloff = 8            -- Garde 8 lignes visibles en haut/bas
o.sidescrolloff = 8        -- Garde 8 colonnes visibles à gauche/droite
o.cursorline = true        -- Highlight la ligne actuelle
o.cursorlineopt = 'number' -- Highlight seulement le numéro de ligne

-- Édition
o.undofile = true          -- Sauvegarde l'historique d'annulation
o.confirm = true           -- Demande confirmation avant de fermer un buffer modifié
o.ignorecase = true        -- Recherche insensible à la casse
o.smartcase = true         -- Mais sensible si majuscule dans la recherche

-- Completion
o.pumheight = 10           -- Limite la hauteur du menu de completion
o.wildmode = "longest:full,full" -- Meilleure completion en ligne de commande
