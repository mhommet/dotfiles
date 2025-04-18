return {
	"yetone/avante.nvim",
	event = { "BufReadPost", "BufNewFile" }, -- Load when opening a file 
	lazy = true,
	version = false, -- Always pull the latest version
	build = "make", -- Build command
	opts = {
	},
	dependencies = {
		{
			"stevearc/dressing.nvim", -- UI improvements for prompts
			lazy = true,
		},
		{
			"nvim-lua/plenary.nvim", -- Utility functions
			lazy = true,
		},
		{
			"MunifTanjim/nui.nvim", -- UI components
			lazy = true,
		},
		{
			"hrsh7th/nvim-cmp", -- Autocompletion for commands and mentions
			lazy = true, -- Don't load until explicitly needed
		},
		{
			"nvim-tree/nvim-web-devicons", -- Icons for UI elements
			lazy = true,
		},
		{
			"zbirenbaum/copilot.lua", -- Support for Copilot as a provider
			cmd = "Copilot",
			event = "InsertEnter",
		},
		{
			"MeanderingProgrammer/render-markdown.nvim", -- Render Markdown and Avante files
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" }, -- Load only for these file types
		},
	},
	config = function()
		require("avante").setup {
			provider = "copilot", -- Set Copilot as the provider
		}
	end,
} 