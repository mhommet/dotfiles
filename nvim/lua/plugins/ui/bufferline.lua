return {
    'akinsho/bufferline.nvim',
    event = "BufAdd", -- Load when first buffer is added
    version = "*",
    dependencies = {
        { 'nvim-tree/nvim-web-devicons', lazy = true },
    },
    opts = {
        options = {
            mode = "buffers", -- Set to "tabs" for a tabs-like experience
            numbers = "none",
            close_command = "bdelete! %d", -- Can be a string or function
            right_mouse_command = "bdelete! %d", -- Close buffer on right-click
            left_mouse_command = "buffer %d", -- Switch buffer on left-click
            middle_mouse_command = nil, -- No action on middle-click
            indicator = {
                icon = '▎', -- Indicator icon
                style = 'icon',
            },
            buffer_close_icon = '󰅖',
            modified_icon = '●',
            close_icon = '',
            left_trunc_marker = '',
            right_trunc_marker = '',
            max_name_length = 18,
            max_prefix_length = 15,
            tab_size = 18,
            diagnostics = "nvim_lsp", -- Use LSP diagnostics
            diagnostics_update_in_insert = false,
            diagnostics_indicator = function(count, level)
                local icon = level:match("error") and " " or " "
                return " " .. icon .. count
            end,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                    separator = true
                }
            },
            color_icons = true,
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = true,
            separator_style = "thin", -- Can be "slant", "thick", "thin", or a table
            enforce_regular_tabs = false,
            always_show_bufferline = false, -- Hide when only one buffer
            hover = {
                enabled = true,
                delay = 200,
                reveal = {'close'}
            },
        }
    }
} 