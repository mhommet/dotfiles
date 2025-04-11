return {
    -- LSP Configuration
    {
        'neovim/nvim-lspconfig',
        config = function()
            require 'configs.lspconfig' -- Charge la configuration dans configs/lspconfig.lua
        end,
        dependencies = {
            'williamboman/mason.nvim', -- LSP/DAP manager
            'williamboman/mason-lspconfig.nvim', -- Mason bridge to lspconfig
            'j-hui/fidget.nvim', -- LSP status UI
            {
                'folke/lazydev.nvim',
                ft = 'lua', -- Charge uniquement pour Lua
                opts = {
                    library = { path = 'luvit-meta/library', words = { 'vim%.uv' } },
                },
            },
            {
                'Bilal2453/luvit-meta',
                lazy = true, -- Charge uniquement à la demande
            },
        },
    },

    -- Autocompletion (nvim-cmp)
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm { select = true },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'path' },
                }),
            }
        end,
    },
    {
      "chrisgrieser/nvim-rip-substitute",
      cmd = "RipSubstitute",
      opts = {},
      keys = {
        {
          "<leader>fs",
          function() require("rip-substitute").sub() end,
          mode = { "n", "x" },
          desc = " rip substitute",
        },
      },
      config = function()
        -- default settings
        require("rip-substitute").setup {
          popupWin = {
            title = " rip-substitute",
            border = "single",
            matchCountHlGroup = "Keyword",
            noMatchHlGroup = "ErrorMsg",
            position = "bottom", ---@type "top"|"bottom"
            hideSearchReplaceLabels = false,
            hideKeymapHints = false,
          },
          prefill = {
            normal = "cursorWord", ---@type "cursorWord"|false
            visual = "selectionFirstLine", ---@type "selectionFirstLine"|false (does not work with ex-command – see README)
            startInReplaceLineIfPrefill = false,
            alsoPrefillReplaceLine = false,
          },
          keymaps = { -- normal mode (if not stated otherwise)
            abort = "q",
            confirm = "<CR>",
            insertModeConfirm = "<C-CR>",
            prevSubstitutionInHistory = "<Up>",
            nextSubstitutionInHistory = "<Down>",
            toggleFixedStrings = "<C-f>", -- ripgrep's `--fixed-strings`
            toggleIgnoreCase = "<C-c>", -- ripgrep's `--ignore-case`
            openAtRegex101 = "R",
            showHelp = "?",
          },
          incrementalPreview = {
            matchHlGroup = "IncSearch",
            rangeBackdrop = {
              enabled = true,
              blend = 50, -- between 0 and 100
            },
          },
          regexOptions = {
            startWithFixedStringsOn = false,
            startWithIgnoreCase = false,
            pcre2 = true, -- enables lookarounds and backreferences, but slightly slower
            autoBraceSimpleCaptureGroups = true, -- disable if using named capture groups (see README for details)
          },
          editingBehavior = {
            -- Typing `()` in the `search` line, automatically adds `$n` to the `replace` line.
            autoCaptureGroups = false,
          },
          notification = {
            onSuccess = true,
            icon = "",
          },
        }
      end,
    },
}

