return { -- mini.nvim
{
    "echasnovski/mini.nvim",
    version = false,
    config = function()
        -- Improve character pairs (parentheses, brackets, etc.)
        require('mini.pairs').setup()

        -- Improve text object selection
        require('mini.ai').setup()
    end
}, -- Code formatting
{
    "stevearc/conform.nvim",
    lazy = true,
    event = {"BufWritePre"},
    cmd = {"ConformInfo"},
    keys = {{
        "<leader>cf",
        function()
            require("conform").format({
                async = true,
                lsp_fallback = true
            })
        end,
        mode = "",
        desc = "Format buffer"
    }},
    opts = {
        formatters_by_ft = {
            lua = {"stylua"},
            python = {"black"},
            javascript = {{"prettierd", "prettier"}},
            typescript = {{"prettierd", "prettier"}},
            javascriptreact = {{"prettierd", "prettier"}},
            typescriptreact = {{"prettierd", "prettier"}},
            json = {{"prettierd", "prettier"}},
            html = {{"prettierd", "prettier"}},
            css = {{"prettierd", "prettier"}},
            scss = {{"prettierd", "prettier"}},
            markdown = {{"prettierd", "prettier"}}
        }
    }
}, -- Linting
{
    "mfussenegger/nvim-lint",
    lazy = true,
    event = {"BufReadPre", "BufNewFile"},
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            javascript = {"eslint_d"},
            typescript = {"eslint_d"},
            javascriptreact = {"eslint_d"},
            typescriptreact = {"eslint_d"},
            python = {"flake8"},
            lua = {"luacheck"}
        }

        -- Create autocmd to run linters
        vim.api.nvim_create_autocmd({"BufWritePost", "BufReadPost", "InsertLeave"}, {
            callback = function()
                require("lint").try_lint()
            end
        })
    end
}, -- Search and Replace
{
    "chrisgrieser/nvim-rip-substitute",
    cmd = "RipSubstitute",
    opts = {},
    keys = {{
        "<leader>fs",
        function()
            require("rip-substitute").sub()
        end,
        mode = {"n", "x"},
        desc = " rip substitute"
    }}
}, {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = {
        open_cmd = "noswapfile vnew"
    },
    keys = {{
        "<leader>sr",
        function()
            require("spectre").open()
        end,
        desc = "Replace in files (Spectre)"
    }}
}, -- Code folding
{
    "kevinhwang91/nvim-ufo",
    dependencies = {"kevinhwang91/promise-async", {
        "luukvbaal/statuscol.nvim",
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                relculright = true,
                segments = {{
                    text = {builtin.foldfunc},
                    click = "v:lua.ScFa"
                }, {
                    text = {"%s"},
                    click = "v:lua.ScSa"
                }, {
                    text = {builtin.lnumfunc, " "},
                    click = "v:lua.ScLa"
                }}
            })
        end
    }},
    event = "BufReadPost",
    opts = {
        provider_selector = function()
            return {"treesitter", "indent"}
        end,
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = ("  %d "):format(endLnum - lnum)
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

                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                    end

                    break
                end

                curWidth = curWidth + chunkWidth
            end

            table.insert(newVirtText, {suffix, "MoreMsg"})
            return newVirtText
        end,

        preview = {
            win_config = {
                border = {"", "─", "", "", "", "─", "", ""},
                winhighlight = "Normal:Folded",
                winblend = 0
            },
            mappings = {
                scrollU = "<C-u>",
                scrollD = "<C-d>",
                jumpTop = "[",
                jumpBot = "]"
            }
        }
    },
    config = function(_, opts)
        -- S'assurer que les options sont configurées
        require("ufo").setup(opts)

        -- Configurer les paramètres de pliage
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        vim.o.foldcolumn = "1"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- Configurer les raccourcis clavier
        vim.keymap.set("n", "zR", require("ufo").openAllFolds)
        vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
        -- Utiliser une fonction plus simple pour zr
        vim.keymap.set("n", "zr", require("ufo").openAllFolds) -- Simplifié
        vim.keymap.set("n", "K", function()
            local winid = require("ufo").peekFoldedLinesUnderCursor()
            if not winid then
                vim.lsp.buf.hover()
            end
        end)
    end
}}
