return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local db = require('dashboard')
    db.setup({
      theme = 'doom',
      config = {
        header = {
          '',
          '   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ',
          '    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ',
          '          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ',
          '           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ',
          '          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ',
          '   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ',
          '  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ',
          ' ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ',
          ' ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ',
          '      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ',
          '       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ',
          '',
        },
        center = {
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Find File           ',
            desc_hl = 'String',
            key = 'f',
            key_hl = 'Number',
            action = 'Telescope find_files'
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Recent Files        ',
            desc_hl = 'String',
            key = 'r',
            key_hl = 'Number',
            action = 'Telescope oldfiles'
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Find Word           ',
            desc_hl = 'String',
            key = 'g',
            key_hl = 'Number',
            action = 'Telescope live_grep'
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'New File            ',
            desc_hl = 'String',
            key = 'n',
            key_hl = 'Number',
            action = 'enew'
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Config              ',
            desc_hl = 'String',
            key = 'c',
            key_hl = 'Number',
            action = 'e ~/.config/nvim/init.lua'
          },
          {
            icon = '󰒲 ',
            icon_hl = 'Title',
            desc = 'Lazy                ',
            desc_hl = 'String',
            key = 'l',
            key_hl = 'Number',
            action = 'Lazy'
          },
          {
            icon = ' ',
            icon_hl = 'Title',
            desc = 'Quit                ',
            desc_hl = 'String',
            key = 'q',
            key_hl = 'Number',
            action = 'qa'
          },
        },
        footer = {
          '',
          '🚀 Neovim is ready',
          '🧠 v' .. vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch,
        }
      }
    })
  end
}
