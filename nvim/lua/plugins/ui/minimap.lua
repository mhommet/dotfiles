return {
    'wfxr/minimap.vim',
    build = "cargo install --locked code-minimap",
    event = "BufReadPost",
    cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
    config = function()
        -- Set minimap width to show more detail
        vim.g.minimap_width = 15
        
        -- Auto-start minimap for code files
        vim.g.minimap_auto_start = 1
        vim.g.minimap_auto_start_win_enter = 1
        
        -- Better code representation - use actual characters instead of dots
        vim.g.minimap_block_filetypes = {'NvimTree', 'neo-tree', 'help', 'alpha', 'dashboard', 'lazy', 'neogitstatus', 'Trouble', 'lir', 'Outline', 'spectre_panel'}
        vim.g.minimap_block_buftypes = {'terminal', 'nofile', 'quickfix', 'prompt'}
        vim.g.minimap_close_filetypes = {'dashboard', 'alpha'}
        
        -- Enable syntax highlighting in minimap
        vim.g.minimap_highlight_range = 1
        vim.g.minimap_highlight_search = 1
        vim.g.minimap_git_colors = 1
        
        -- Ensure we're using code-minimap for better display
        vim.g.minimap_base64encode = 0
        vim.g.minimap_block_encodereuse = 1
        
        -- Set the code-minimap executable path explicitly
        if vim.fn.executable('/home/mhommet/.cargo/bin/code-minimap') == 1 then
            vim.g.minimap_cmd = '/home/mhommet/.cargo/bin/code-minimap'
        else
            vim.g.minimap_cmd = 'code-minimap'
        end
        
        -- Toggle minimap with F7
        vim.keymap.set('n', '<F7>', ':MinimapToggle<CR>', { silent = true })
        
        -- Add autocmd to update minimap when saving file
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = "*",
            callback = function()
                vim.cmd('MinimapRefresh')
            end,
        })
        
        -- Make a keybinding to force minimap update when needed
        vim.keymap.set('n', '<leader>mr', ':MinimapRefresh<CR>', { silent = true, desc = "Refresh Minimap" })
    end,
} 