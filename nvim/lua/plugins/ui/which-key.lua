return {
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