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
            event = "InsertEnter",
            opts = {
                bind = true,
                handler_opts = {
                    border = "rounded"
                }
            },
        })
    end,
}
