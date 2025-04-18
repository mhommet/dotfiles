return {
	'folke/which-key.nvim',
	keys = { "<leader>", "[", "]", "g" },
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		require('which-key').setup({
			plugins = {
				presets = {
					operators = false,
					motions = false,
				},
			},
		})
		require('which-key').add {
			{ '<leader>d', group = 'Document' },
			{ '<leader>r', group = 'Refactor' },
			{ '<leader>s', group = 'Search' },
			{ '<leader>w', group = 'Workspace' },
			{ '<leader>t', group = 'Toggle' },
			{ '<leader>h', group = 'Git Hunk', mode = { 'n', 'v' } },
			{ '<leader>x', group = 'Trouble', desc = 'Diagnostics' },
			{ '<leader>f', group = 'Find/File' },
			{ '<leader>b', group = 'Buffer' },
			{ '<leader>c', group = 'Code' },
			{ '<leader>g', group = 'Git' },
			{ '<leader>l', group = 'LSP' },
			{ '<leader>n', group = 'Notifications' },
			{ '<leader>p', group = 'Project' },
			{ '<leader>q', group = 'Quickfix' },
			{ '[', group = 'Previous' },
			{ ']', group = 'Next' },
			{ 'g', group = 'Go To' },
		}
	end,
} 