return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				transparent_background = true,
				term_colors = true,
				styles = {
					comments = { "italic" },
					functions = { "italic" },
					variables = { "italic" },
					sidebars = { "dark" },
					floats = { "dark" },
				},
				integrations = {
					telescope = true,
					nvimtree = true,
					lsp_trouble = true,
					lsp_saga = true,
					markdown = true,
					cmp = true,
					gitsigns = true,
					treesitter = true,
					which_key = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end
	},
	-- Lualine Statusline
	{
		'nvim-lualine/lualine.nvim',
		opts = function()
			require('lualine').setup {
				options = {
					theme = "auto",
					component_separators = '',
					section_separators = { left = '', right = '' },
				},
				sections = {
					lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
					lualine_b = { 'filename', 'branch' },
					lualine_c = {
						'%=', --[[ add your center components here in place of this comment ]]
					},
					lualine_x = {},
					lualine_y = { 'filetype', 'progress' },
					lualine_z = {
						{ 'location', separator = { right = '' }, left_padding = 2 },
					},
				},
				inactive_sections = {
					lualine_a = { 'filename' },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = { 'location' },
				},
				tabline = {},
				extensions = {},
			}
		end,
	},

	-- Mini.nvim for enhanced text objects and surrounding
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup()
			require("mini.surround").setup()
			require("mini.files").setup()
		end,
	},

	-- Todo Comments
	{
		'folke/todo-comments.nvim',
		event = 'VimEnter',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {
			signs = false,
		},
	},

	-- Which Key (Keybinding Helper)
	{
		'folke/which-key.nvim',
		event = 'VimEnter',
		config = function()
			require('which-key').setup()
			require('which-key').add {
				{ '<leader>d', group = 'Document' },
				{ '<leader>r', group = 'Refactor' },
				{ '<leader>s', group = 'Search' },
				{ '<leader>w', group = 'Workspace' },
				{ '<leader>t', group = 'Toggle' },
				{ '<leader>h', group = 'Git Hunk', mode = { 'n', 'v' } },
			}
		end,
	},
	{
		'goolord/alpha-nvim',
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			-- Nouveau logo ASCII
			local art = {
				[[]],
				[[                      ██████                     ]],
				[[                  ████▒▒▒▒▒▒████                 ]],
				[[                ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██               ]],
				[[              ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██             ]],
				[[            ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒               ]],
				[[            ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▓▓▓▓           ]],
				[[            ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓           ]],
				[[          ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██         ]],
				[[          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██         ]],
				[[          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██         ]],
				[[          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██         ]],
				[[          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██         ]],
				[[          ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██         ]],
				[[          ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██         ]],
				[[          ██      ██      ████      ████         ]],
				[[                                                 ]],
				[[]],
			}

			-- Calculer l'espace vertical pour centrer l'art
			local total_lines = vim.o.lines -- hauteur totale de la fenêtre
			local art_lines = #art -- nombre de lignes de l'art
			local padding_top = math.floor((total_lines - art_lines) / 2) -
			    2     -- réduire de 2 pour remonter l'art
			local padding_bottom = total_lines - art_lines -
			    padding_top -- s'assurer qu'il reste un espace égal en bas

			-- Remplir l'espace avec des lignes vides avant l'art
			local centered_art = {}
			for i = 1, padding_top do
				table.insert(centered_art, "") -- ajouter des lignes vides avant l'art
			end
			for _, line in ipairs(art) do
				table.insert(centered_art, line) -- ajouter l'art ASCII
			end
			for i = 1, padding_bottom do
				table.insert(centered_art, "") -- ajouter des lignes vides après l'art
			end

			-- Assigner l'art centré à la section header
			dashboard.section.header.val = centered_art

			-- Vide les boutons
			dashboard.section.buttons.val = {}

			-- Configurer Alpha
			alpha.setup(dashboard.opts)
		end
	}
}
