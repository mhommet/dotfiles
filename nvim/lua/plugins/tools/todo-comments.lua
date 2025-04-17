return {
	'folke/todo-comments.nvim',
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TodoTrouble", "TodoTelescope" },
	keys = {
		{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
		{ "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
		{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
	},
	dependencies = { 'nvim-lua/plenary.nvim' },
	opts = {
		signs = false,
	},
} 