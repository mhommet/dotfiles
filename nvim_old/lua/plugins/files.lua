return {
  -- Oil.nvim: File browser with an intuitive UI
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = {
      { "echasnovski/mini.icons", opts = {} },
      -- Uncomment the next line if you prefer nvim-web-devicons instead of mini.icons
      -- "nvim-tree/nvim-web-devicons",
    },
  },

  -- Telescope: Fuzzy Finder for files, LSP, and more
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',        -- Load on VimEnter for better startup performance
    branch = '0.1.x',          -- Use a stable branch for compatibility
    dependencies = {
      'nvim-lua/plenary.nvim', -- Utility functions required by Telescope

      -- FZF Native: Faster sorting for Telescope
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',                         -- Build the plugin with `make`
        cond = function()
          return vim.fn.executable('make') == 1 -- Only load if `make` is available
        end,
      },

      -- UI Select: Better UI for Telescope pickers
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Icons: Use nvim-web-devicons if NERD Fonts are available
      {
        'nvim-tree/nvim-web-devicons',
        enabled = vim.g.have_nerd_font, -- Conditional loading based on `vim.g.have_nerd_font`
      },
    },

    config = function()
      -- Telescope setup
      require('telescope').setup {
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown() }, -- Dropdown theme for UI Select
        },
      }

      -- Load Telescope extensions
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- Telescope keybindings
      local builtin = require 'telescope.builtin'

      -- Basic keymaps for Telescope
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search Help' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search Keymaps' })
      vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Search Files' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Search Select Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search Current Word' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by Grep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search Diagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search Resume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Search Recent Files' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Search Buffers' })

      -- Advanced keymaps with themes and additional configurations
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10, previewer = false,
        })
      end, { desc = 'Search Current Buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true, -- Limit search to open files
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = 'Search Open Files' })

      -- Shortcut to search Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Search Neovim Config' })
    end,
  },
}
