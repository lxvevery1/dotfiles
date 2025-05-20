-- Show function signature when you type
-- This nvim plugin is made for completion plugins that do not support signature help.
-- Need neovim-0.8+ and enable nvim-lsp. (check neovim-0.5/neovim-0.6/neovim-0.9 branch for earlier version support)
-- Inspired by completion-nvim, which does have lots of cool features.
-- Fully asynchronous lsp buf request.
-- Virtual text available

return {
    "ray-x/lsp_signature.nvim",
    config = function()
        require("lsp_signature").setup({
            bind = true,                           -- This is mandatory, otherwise border config won't be applied
            hint_enable = true,                    -- Enable inline hints
            floating_window = true,                -- Use a floating window for signature help
            floating_window_above_cur_line = true, -- Place the floating window above the current line if possible
            hint_prefix = "Hint ",                 -- Prefix for inline hints
            hint_inline = function() return false end,
            doc_lines = 2,                         -- Number of lines shown in the popup for the documentation
            max_height = 12,                       -- Maximum height of the floating window
            max_width = 80,                        -- Maximum width of the floating window
            handler_opts = {
                border = "rounded",                -- Border style for the floating window
            },
            always_trigger = true,                 -- Automatically trigger the signature help popup
            auto_close_after = nil,                -- Keep the popup open unless explicitly closed
            zindex = 50,                           -- Z-index for the floating window
            toggle_key = "<C-s>",                  -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
        })
    end,
}
