return {
    "ray-x/lsp_signature.nvim",
    config = function()
        require("lsp_signature").setup({
            bind = true, -- This is mandatory, otherwise border config won't be applied
            hint_enable = true, -- Enable inline hints
            floating_window = true, -- Use a floating window for signature help
            floating_window_above_cur_line = true, -- Place the floating window above the current line if possible
            hint_prefix = "🔍 ", -- Prefix for inline hints
            doc_lines = 2, -- Number of lines shown in the popup for the documentation
            max_height = 12, -- Maximum height of the floating window
            max_width = 80, -- Maximum width of the floating window
            handler_opts = {
                border = "rounded", -- Border style for the floating window
            },
            always_trigger = true, -- Automatically trigger the signature help popup
            auto_close_after = nil, -- Keep the popup open unless explicitly closed
            zindex = 50, -- Z-index for the floating window
        })
    end,
}
