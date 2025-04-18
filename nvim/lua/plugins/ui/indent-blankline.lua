return {
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
} 