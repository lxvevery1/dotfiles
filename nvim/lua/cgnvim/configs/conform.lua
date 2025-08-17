-- Lightweight yet powerful formatter plugin for Neovim
return {
    require("conform").setup({
        formatters = {
            ["clang-format"] = {
                prepend_args = { "-style", "Microsoft" },
            },
            ["tidy"] = {
                command = "tidy",
                args = { "-config", "~/.config/tidy/tidy.conf" },
            },
            ["csharpier"] = {
                command = "csharpier",
                args = { "--stdin-filepath", "$FILENAME" },
                stdin = true,
            },
        },
        formatters_by_ft = {
            lua = { "lua-format", lsp_format = "fallback" },
            python = { "isort", "black", lsp_format = "fallback" },
            rust = { "rustfmt", lsp_format = "fallback" },
            xml = { "tidy", lsp_format = "fallback" },
            cs = { "csharpier", lsp_format = "fallback" },
            c = { "clang_format", lsp_format = "fallback", },
            cpp = { "clang_format", lsp_format = "fallback", },
            asm = { "asmfmt", lsp_format = "fallback" }
        },
    }),
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
            require("conform").format({ bufnr = args.buf })
        end,
    })
}
