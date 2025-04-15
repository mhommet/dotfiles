return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup()
		require("mini.surround").setup()
		require("mini.files").setup()
		require("mini.comment").setup()
		require("mini.notify").setup()
	end,
} 