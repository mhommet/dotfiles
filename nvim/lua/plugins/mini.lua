return {
	"echasnovski/mini.nvim",
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{ "<leader>e", function() require("mini.files").open() end, desc = "Open MiniFiles" },
	},
	config = function()
		require("mini.surround").setup()
		require("mini.files").setup()
		require("mini.comment").setup()
		
		-- Make the MiniFiles global to avoid "not found" errors
		_G.MiniFiles = require("mini.files")
	end,
}