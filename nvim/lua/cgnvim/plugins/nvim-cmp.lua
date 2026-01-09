return {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
    },
    opts = function()
        local cmp = require("cmp")
        local opts = require("cgnvim.configs.nvim-cmp")
        opts.mapping["<Tab>"] = cmp.config.disable
        opts.mapping["<S-Tab>"] = cmp.config.disable
        return opts
    end,
}
