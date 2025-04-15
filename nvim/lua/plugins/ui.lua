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
			require("mini.comment").setup()
			require("mini.pairs").setup()
			require("mini.notify").setup()
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

			dashboard.config.layout = {
				{ type = "padding", val = 1 },
				dashboard.section.header,
				{ type = "padding", val = 2 },
				dashboard.section.buttons,
				{ type = "padding", val = 1 },
				dashboard.section.footer,
			}

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

			local centered_art = {}
			for _ = 1, 3 do
				table.insert(centered_art, "")
			end
			for _, line in ipairs(art) do
				table.insert(centered_art, line)
			end
			dashboard.section.header.val = centered_art

			-- Vide les boutons
			dashboard.section.buttons.val = {}

			-- Footer

			local function footer()
				-- Neovim version, time and date
				local version = vim.version()
				local nvim_version = string.format("Neovim %d.%d.%d", version.major, version.minor,
					version.patch)

				-- Startup time (safe fallback)
				local startup_time = "N/A"
				if vim.g.startuptime_start then
					startup_time = string.format("%.2f",
						vim.fn.reltimefloat(vim.fn.reltime(vim.g.startuptime_start)))
				end

				local footer_text = string.format(
					" %s - Started in  %s ms ",
					nvim_version,
					startup_time
				)

				return footer_text
			end
			dashboard.section.footer.val = footer()

			-- Configurer Alpha
			alpha.setup(dashboard.opts)
		end
	}
}
