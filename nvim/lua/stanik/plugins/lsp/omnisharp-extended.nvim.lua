return {
    "Hoffs/omnisharp-extended-lsp.nvim",

    priority = 100,
    config = function()
        local opts = { noremap = true, silent = true }

        -- Telescope variants
        vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua require("omnisharp_extended").telescope_lsp_definition()<cr>',
            opts)
        vim.api.nvim_set_keymap('n', '<leader>D',
            '<cmd>lua require("omnisharp_extended").telescope_lsp_type_definition()<cr>', opts)
        vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua require("omnisharp_extended").telescope_lsp_references()<cr>',
            opts)
        vim.api.nvim_set_keymap('n', 'gi',
            '<cmd>lua require("omnisharp_extended").telescope_lsp_implementations()<cr>', opts)
    end,
}
