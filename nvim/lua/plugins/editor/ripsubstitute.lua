return {
    'chrisgrieser/nvim-rip-substitute',
    config = function()
        require('rip-substitute').setup {
            -- Add any additional configuration options here
            on_open = function()
                -- Ensure the buffer name is unique
                local buf_name = 'RipSubstitute'
                local buf_exists = vim.fn.bufexists(buf_name) == 1
                if buf_exists then
                    vim.cmd('bwipeout ' .. buf_name)
                end
            end
        }
    end
}
