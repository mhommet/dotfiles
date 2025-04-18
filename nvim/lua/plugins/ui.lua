return {
  -- Alpha
  {
    'goolord/alpha-nvim',
    lazy = false, -- Dashboard must be loaded immediately for the welcome screen
    priority = 900, -- Priority just after the theme
    dependencies = { 
      { 'nvim-tree/nvim-web-devicons', lazy = true, module = true },
      { 
        'rcarriga/nvim-notify', 
        lazy = true,
        module = true,
        init = function()
          -- Store the real notify until alpha is loaded
          if not vim._original_notify then
            vim._original_notify = vim.notify
          end
          
          -- Use a basic notify function until nvim-notify is loaded
          vim.notify = function(msg, level, opts)
            if vim._original_notify then
              return vim._original_notify(msg, level, opts)
            else
              return vim.api.nvim_echo({{msg, level or "INFO"}}, true, {})
            end
          end
        end,
      },
    },
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

      -- ASCII Art Logo
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
      dashboard.section.header.opts.hl = "DashboardHeader"

      -- Navigation Buttons avec style amélioré
      local function button(sc, txt, keybind)
        local btn = dashboard.button(sc, txt, keybind)
        btn.opts.hl = "DashboardCenter"
        btn.opts.hl_shortcut = "DashboardShortcut"
        return btn
      end

      dashboard.section.buttons.val = {
        button("f", "🔍  Find File", ":Telescope find_files<CR>"),
        button("e", "✨  New File", ":ene <BAR> startinsert<CR>"),
        button("r", "🕒  Recent Files", ":Telescope oldfiles<CR>"),
        button("t", "🔎  Find Text", ":Telescope live_grep<CR>"),
        button("c", "⚙️   Configuration", ":e $MYVIMRC <CR>"),
        button("l", "📦  Lazy", ":Lazy<CR>"),
        button("q", "🚪  Quit", ":qa<CR>"),
      }

      -- Footer avec style simplifié et formaté
      local function footer()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        return string.format("⚡ Neovim loaded %d/%d plugins in %.2fms", 
          stats.loaded, 
          stats.count, 
          ms
        )
      end
      
      dashboard.section.footer.val = footer()
      dashboard.section.footer.opts.hl = "DashboardFooter"

      -- Configure Alpha
      alpha.setup(dashboard.opts)
      
      -- Fermer Lazy et le rouvrir si nécessaire après le chargement du dashboard
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end
      
      -- Auto-command to update footer when all plugins are loaded
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          dashboard.section.footer.val = footer()
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
      
      -- Load nvim-notify lazily after Alpha is done
      vim.defer_fn(function()
        require("lazy").load({ plugins = { "nvim-notify" }})
        if vim._original_notify then
          vim.notify = vim._original_notify
        end
      end, 500)
    end
  },

  -- Which-Key
  {
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
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        preset = "helix",
        window = {
          border = "single",
          position = "bottom",
          margin = { 1, 0, 1, 0 },
          padding = { 1, 2, 1, 2 },
          winblend = 0,
        },
        icons = {
          breadcrumb = "»",
          separator = "➜",
          group = "+",
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
  },

  -- Notify
  {
    'rcarriga/nvim-notify',
    lazy = true,
    config = function()
      local notify = require('notify')
      notify.setup({
        -- Animation style
        stages = 'fade_in_slide_out',
        -- Default display duration for notifications
        timeout = 3000,
        -- Notification limits
        max_width = 80,
        max_height = 20,
        -- Background opacity (fix for warnings)
        background_colour = "#000000",
        -- Icons for notification levels (requires Nerd Font)
        icons = {
          ERROR = '',
          WARN = '',
          INFO = '',
          DEBUG = '',
          TRACE = '✎',
        },
        -- Set minimum width
        minimum_width = 50,
        -- Add render options
        render = "default",
        -- Add top_down option
        top_down = true,
      })
      
      -- Store the original notify function for Noice to use later
      vim._original_notify = notify
    end,
  },

  -- Noice
  {
    'folke/noice.nvim',
    event = "VeryLazy",
    cmd = {
      "NoiceEnable",
      "NoiceDisable",
      "NoiceToggle",
      "NoiceErrors",
      "NoiceLast",
      "NoiceTelescope",
    },
    keys = {
      { "<leader>fn", function() require("noice").cmd("telescope") end, desc = "Noice Telescope" },
      { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
      'hrsh7th/nvim-cmp', -- Need cmp for cmdline
    },
    config = function()
      require('noice').setup({
        lsp = {
          -- Override LSP message system
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
          },
          -- Display signatures in insert mode
          signature = {
            enabled = true,
            auto_open = {
              enabled = true,
              trigger = true, -- Afficher automatiquement quand le serveur LSP l'envoie
              luasnip = true, -- Marche bien avec LuaSnip
            },
          },
          -- Display progress messages
          progress = {
            enabled = true,
            format = "lsp_progress",
            format_done = "lsp_progress_done",
            throttle = 1000 / 30, -- throttle in ms
          },
          -- Display hover information
          hover = {
            enabled = true,
          },
          -- Plus d'options de documentation
          documentation = {
            opts = {
              win_options = {
                concealcursor = "n", -- Cacher les curseurs en mode normal
                conceallevel = 3, -- Cacher tout au maximum
              },
            },
          },
        },
        
        -- Amélioration pour gestion des focus
        routes = {
          {
            filter = {
              event = "msg_show",
              find = "written",
            },
            opts = { skip = true },
          },
          -- Filter out "hls module not available" messages
          {
            filter = {
              event = "msg_show",
              find = "hls module not available",
            },
            opts = { skip = true },
          },
          
          -- Ajout: gestion de focus pour les notifications
          {
            filter = {
              ["not"] = {
                event = "lsp",
                kind = "progress",
              },
              cond = function()
                -- Vérifier si la fenêtre est en focus
                local focused = true
                local win = vim.api.nvim_get_current_win()
                local win_config = vim.api.nvim_win_get_config(win)
                if win_config and win_config.relative ~= "" then
                  focused = false
                end
                return not focused
              end,
            },
            view = "notify_send",
            opts = { stop = false, replace = true },
          },
        },
        
        -- Configure message popups
        messages = {
          enabled = true,
          view = 'notify',
          view_error = 'notify',
          view_warn = 'notify',
          view_history = 'messages',
          view_search = 'virtualtext',
        },
        
        -- Command line at the bottom
        cmdline = {
          enabled = true,
          view = 'cmdline',
          format = {
            cmdline = { icon = '>' },
            search_down = { icon = '🔍⌄' },
            search_up = { icon = '🔍⌃' },
            filter = { icon = '$' },
            lua = { icon = '☾' },
            help = { icon = '?' },
          },
        },
        
        -- Configure notifications - IMPORTANT: Disable overriding of vim.notify
        notify = {
          enabled = false, -- Disable Noice's notification system override
          view = 'notify',
        },
        
        -- More subtle popupmenu
        popupmenu = {
          enabled = true,
          backend = 'nui',
        },
        
        -- Hide ~ messages at end of buffer
        views = {
          cmdline = {
            position = {
              row = -1,
              col = 0,
            },
            size = {
              width = "100%",
              height = "auto",
            },
          },
          mini = {
            win_options = {
              winblend = 0,
            },
          },
        },
        
        -- Quiet mode presets
        presets = {
          bottom_search = true,         -- Utiliser une ligne de recherche en bas
          command_palette = true,       -- Utiliser un menu de commandes
          long_message_to_split = true, -- Ouvrir les longs messages dans un split
          inc_rename = true,            -- Support pour inc-rename.nvim
          lsp_doc_border = true,        -- Ajouter une bordure pour les docs LSP
        },
        
        -- Ajouter un hook pour markdown
        on_init = function()
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function(event)
              vim.schedule(function()
                if require("noice.util").has("nvim-treesitter") then
                  require("noice.text.markdown").keys(event.buf)
                end
              end)
            end,
          })
        end,
      })
    end,
  },
  
  -- Autres plugins d'interface utilisateur
  { "akinsho/bufferline.nvim", opts = { options = { separator_style = "slope" } } },
  
  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { enabled = true },
    },
  },
} 