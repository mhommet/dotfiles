return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
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
} 