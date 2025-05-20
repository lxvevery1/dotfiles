return {
    "mrcjkb/rustaceanvim",
    version = '^5',
    lazy = false,

    config = function()
        vim.g.rustaceanvim = {
            server = {
                default_settings = {
                    -- rust-analyzer language server configuration
                    ["rust-analyzer"] = {
                        diagnostics = {
                            enabled = true,
                            disabled = { "needless_return" },
                            enableExperimental = true,
                        },
                        cargo = {
                            allFeatures = true,
                        }
                    },
                },
            },
        }
    end,
}
