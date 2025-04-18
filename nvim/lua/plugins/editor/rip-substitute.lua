return {
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
} 