return {
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