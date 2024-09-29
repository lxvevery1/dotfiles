return {
    "VonHeikemen/lsp-zero.nvim",
    config = function()
        local lsp_zero = require("lsp-zero")
        lsp_zero.format_on_save({
            format_opts = {
                async = true,
                timeout_ms = 10000,
            },
            servers = {
                ['rust-analyzer'] = { 'rust' },
                ['clangd'] = { 'c', 'cpp' },
            }
        })
    end
}
