return {
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
} 