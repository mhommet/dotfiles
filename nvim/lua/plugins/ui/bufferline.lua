return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"catppuccin/nvim",
	},
	config = function()
		require("bufferline").setup({
			options = {
				-- Utilise la police avec icônes
				separator_style = "slant",
				show_buffer_close_icons = true,
				show_close_icon = false,
				-- Afficher les numéros pour faciliter la navigation
				numbers = "ordinal",
				-- Ne pas dépasser la largeur de l'écran
				enforce_regular_tabs = false,
				max_name_length = 18,
				max_prefix_length = 15,
				-- Permet de cliquer sur les onglets
				mouse_wheel_in_tabs = true,
				show_tab_indicators = true,
				-- Style personnalisé
				highlights = require("catppuccin.groups.integrations.bufferline").get(),
				-- Intégration avec d'autres plugins
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
				-- Indicateurs d'offset pour les plugins qui utilisent des fenêtres flottantes
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},
			},
		})

		-- Raccourcis clavier
		local keymap = vim.keymap.set

		-- Navigation entre les buffers
		keymap("n", "<leader>bp", "<cmd>BufferLineCyclePrev<CR>", { desc = "Précédent" })
		keymap("n", "<leader>bn", "<cmd>BufferLineCycleNext<CR>", { desc = "Suivant" })
		
		-- Groupe principal de raccourcis pour bufferline
		keymap("n", "<leader>b", "<nop>", { desc = "Buffers" })
		
		-- Réorganisation
		keymap("n", "<leader>bm", "<nop>", { desc = "Déplacer" })
		keymap("n", "<leader>bml", "<cmd>BufferLineMoveNext<CR>", { desc = "Déplacer à droite" })
		keymap("n", "<leader>bmh", "<cmd>BufferLineMovePrev<CR>", { desc = "Déplacer à gauche" })
		
		-- Tri et sélection
		keymap("n", "<leader>bs", "<cmd>BufferLinePick<CR>", { desc = "Sélectionner buffer" })
		keymap("n", "<leader>bd", "<cmd>BufferLinePickClose<CR>", { desc = "Fermer buffer" })
		keymap("n", "<leader>bsd", "<cmd>BufferLineSortByDirectory<CR>", { desc = "Trier par dossier" })
		
		-- Fermeture de buffers
		keymap("n", "<leader>bc", "<cmd>BufferLineCloseOthers<CR>", { desc = "Fermer autres buffers" })
		keymap("n", "<leader>bx", "<cmd>bdelete<CR>", { desc = "Fermer buffer actuel" })
		
		-- Allerà des positions spécifiques dans bufferline
		for i = 1, 9 do
			keymap("n", "<leader>b" .. i, "<cmd>BufferLineGoToBuffer " .. i .. "<CR>", { desc = "Aller au buffer " .. i })
		end
	end,
} 