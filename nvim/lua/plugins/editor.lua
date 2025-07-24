return {{
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>f',
            function()
                require('conform').format {
                    async = true,
                    lsp_fallback = true,
                }
            end,
            mode = '',
            desc = 'Format buffer',
        },
    },
    opts = {
        notify_on_error = false,
        formatters_by_ft = {
            lua = { 'stylua' },
            python = { 'black' },
            javascript = { 'prettier' },
            php = { { 'phpactor', 'format' } },
        },
    },
},
{
    -- Color Highlighter (Preview colors in code)
    {
        'norcalli/nvim-colorizer.lua',
        event = "BufReadPre",
        config = function()
            require("colorizer").setup({
                -- List of filetypes to colorize
                '*'; -- Colorize all filetypes
                'css';
                'scss';
                'sass';
                'html';
                'javascript';
                'typescript';
                'jsx';
                'tsx';
            }, {
                -- Default options
                RGB = true;       -- #RGB hex codes
                RRGGBB = true;    -- #RRGGBB hex codes
                names = false;    -- "Name" codes like Blue
                RRGGBBAA = true;  -- #RRGGBBAA hex codes
                rgb_fn = true;    -- CSS rgb() and rgba() functions
                hsl_fn = true;    -- CSS hsl() and hsla() functions
                css = true;       -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true;    -- Enable all CSS *functions*: rgb_fn, hsl_fn
                
                -- Options spécifiques aux filetypes peuvent être définies comme ceci:
                -- sass = { mode = 'background' },
                
                -- Mode global
                mode = 'background'; -- 'foreground' or 'background' or 'virtualtext'
            })
        end
    },
    
    -- Better Rainbow Parentheses
    {
        'HiPhish/rainbow-delimiters.nvim',
        event = "BufReadPost",
        config = function()
            local rainbow_delimiters = require('rainbow-delimiters')
            
            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = rainbow_delimiters.strategy['global'],
                    vim = rainbow_delimiters.strategy['local'],
                },
                query = {
                    [''] = 'rainbow-delimiters',
                    lua = 'rainbow-blocks',
                    javascript = 'rainbow-delimiters-react',
                    typescript = 'rainbow-delimiters-react',
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
                blacklist = {'markdown'},
            }
        end
    },
}, {
    {
        'dnlhc/glance.nvim',
        config = function()
            local glance = require('glance')
            local actions = glance.actions
            
            glance.setup({
                height = 18, -- Height of the window
                zindex = 45,
                
                -- Mappings inside the window
                mappings = {
                    list = {
                        ['j'] = actions.next,
                        ['k'] = actions.previous,
                        ['<C-u>'] = actions.preview_scroll_win(5),
                        ['<C-d>'] = actions.preview_scroll_win(-5),
                        ['v'] = actions.jump_vsplit,
                        ['s'] = actions.jump_split,
                        ['t'] = actions.jump_tab,
                        ['<CR>'] = actions.jump,
                        ['o'] = actions.jump,
                        ['<leader>l'] = actions.enter_win('preview'),
                        ['q'] = actions.close,
                        ['Q'] = actions.close,
                        ['<Esc>'] = actions.close,
                    },
                    preview = {
                        ['q'] = actions.close,
                        ['Q'] = actions.close,
                        ['<Esc>'] = actions.close,
                        ['<leader>l'] = actions.enter_win('list'),
                    },
                },
                
                -- List with borders, preview without borders
                border = {
                    enable = true,
                    top_char = '─',
                    bottom_char = '─',
                    right_char = '│',
                    left_char = '│',
                    top_left_char = '╭',
                    top_right_char = '╮',
                    bottom_left_char = '╰',
                    bottom_right_char = '╯',
                },
                
                -- Appearance
                theme = { -- Custom style
                    enable = true,
                    mode = 'auto',
                },
                
                -- Results order
                folds = {
                    fold_closed = '›',
                    fold_open = '⤵',
                    folded = true,
                },
                
                -- Type-specific options
                hooks = {
                    before_open = function(results, open, jump, method)
                        if #results == 1 then
                            jump(results[1]) -- Go directly to the result if there's only one
                        else
                            open(results) -- Otherwise, open the Glance window
                        end
                    end,
                },
                
                -- Type-specific options
                lists = {
                    -- Configuration for references
                    references = {
                        prompt_title = 'References',
                    },
                    -- Configuration for definitions
                    definitions = {
                        prompt_title = 'Definitions',
                    },
                    -- Configuration for implementations
                    implementations = {
                        prompt_title = 'Implementations',
                    },
                    -- Configuration for type definitions
                    type_definitions = {
                        prompt_title = 'Type Definitions',
                    },
                },
            })
            
            -- Keymaps to replace default LSP commands
            vim.keymap.set('n', 'gd', '<CMD>Glance definitions<CR>', { desc = 'Glance Definitions' })
            vim.keymap.set('n', 'gr', '<CMD>Glance references<CR>', { desc = 'Glance References' })
            vim.keymap.set('n', 'gD', '<CMD>Glance type_definitions<CR>', { desc = 'Glance Type Definitions' })
            vim.keymap.set('n', 'gI', '<CMD>Glance implementations<CR>', { desc = 'Glance Implementations' })
        end
    }
} , {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
        indent = {
            char = '│', -- Line character
            tab_char = '│', -- Tab character
        },
        scope = {
            enabled = true,
            show_start = true,
            show_end = false,
            injected_languages = true,
            priority = 1000,
            include = {
                node_type = {
                    ["*"] = {
                        "argument_list",
                        "arguments",
                        "assignment_statement",
                        "block",
                        "class",
                        "dictionary",
                        "do_block",
                        "element",
                        "except",
                        "for",
                        "function",
                        "if_statement",
                        "list_literal",
                        "method",
                        "object",
                        "operation_type",
                        "table",
                        "try",
                        "while",
                    },
                },
            },
        },
        exclude = {
            filetypes = {
                "help",
                "dashboard",
                "lazy",
                "neogitstatus",
                "NvimTree",
                "Trouble",
                "text",
                "mason",
            },
            buftypes = {
                "terminal",
                "nofile",
                "quickfix",
                "prompt",
            },
        },
    },
},{
    'chrisgrieser/nvim-rip-substitute',
    config = function()
        require('rip-substitute').setup {
            on_open = function()
                -- Ensure unique buffer name for RipSubstitute
                local buf_name = 'RipSubstitute'
                if vim.fn.bufexists(buf_name) == 1 then
                    vim.cmd('bwipeout ' .. buf_name)
                end
            end,
        }
    end,
},{
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
},
{
    'kevinhwang91/nvim-ufo',
    dependencies = {
        'kevinhwang91/promise-async',
        'nvim-treesitter/nvim-treesitter'
    },
    config = function()
        vim.o.foldcolumn = '1' -- '0' is no fold column, '1' is with fold column
        vim.o.foldlevel = 99   -- High fold level to open all folds by default
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- Define provider handlers
        local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = ('  %d lines'):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, {chunkText, hlGroup})
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            
            table.insert(newVirtText, {'', 'UfoFoldedEllipsis'})
            table.insert(newVirtText, {suffix, 'UfoFoldedFg'})
            
            return newVirtText
        end
        
        -- Add a safer provider selector
        local function safe_provider_selector(bufnr, filetype, buftype)
            -- Exclude unsupported filetypes to avoid errors
            local excluded_filetypes = { 'help', 'vim', 'markdown', 'tex', 'man', 'org', 'neorg', 'norg' }
            
            for _, ft in ipairs(excluded_filetypes) do
                if ft == filetype then
                    return { 'indent' }  -- Fallback to indent for these types
                end
            end
            
            -- For all other filetypes, just use indent as the only reliable source
            return { 'indent' }
        end

        -- Setup with simpler configuration to avoid errors
        require('ufo').setup({
            open_fold_hl_timeout = 150,
            
            -- Updated to use the new parameter name
            close_fold_kinds_for_ft = {
                default = {'imports', 'comment'},
            },
            
            preview = {
                win_config = {
                    border = 'rounded',
                    winhighlight = 'Normal:Folded',
                    winblend = 0
                },
                mappings = {
                    scrollU = '<C-u>',
                    scrollD = '<C-d>',
                    jumpTop = '[',
                    jumpBot = ']'
                }
            },
            
            -- Use handler for fold text
            fold_virt_text_handler = handler,
            
            -- Use safer provider selection
            provider_selector = safe_provider_selector,
            
            -- Enable this for better compatibility
            enable_get_fold_virt_text = true,
        })

        -- Keymaps to use UFO
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
        vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
        vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith)
        
        -- Fold preview with fallback to LSP hover
        -- Use pcall to prevent errors
        vim.keymap.set('n', 'K', function()
            local status, winid = pcall(require('ufo').peekFoldedLinesUnderCursor)
            if not status or not winid then
                -- Fallback to LSP hover if UFO fails
                vim.lsp.buf.hover()
            end
        end)
    end
}
} 
