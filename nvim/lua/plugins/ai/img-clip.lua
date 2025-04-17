return {
    "HakonHarnes/img-clip.nvim", -- Image pasting support
    lazy = true,
    cmd = "PasteImage", -- Load only when pasting an image
    ft = { "markdown", "Avante" }, -- Load for specific file types
    opts = {
        embed_image_as_base64 = false, -- Embed image as base64 (false for external file)
        prompt_for_file_name = false, -- No prompt for file name on paste
        drag_and_drop = {
            insert_mode = true, -- Enable drag-and-drop in insert mode
        },
        use_absolute_path = true, -- Use absolute paths (important for Windows)
    },
} 