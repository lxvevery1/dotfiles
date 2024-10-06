return {
    "stevearc/conform.nvim",
    opts = {},

    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "lua-format", lsp_format = "fallback" },
                python = { "isort", "black", lsp_format = "fallback" },
                rust = { "rustfmt", lsp_format = "fallback" },
                xml = { "xmllint", lsp_format = "fallback" },
                cs = { "csharpier", lsp_format = "fallback" },
            },
        })

        -- format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                require("conform").format({ bufnr = args.buf })
            end,
        })
    end,
}
