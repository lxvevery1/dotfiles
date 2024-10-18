return {
    "Hoffs/omnisharp-extended-lsp.nvim", -- Replace with the actual repo URL

    priority = 100,
    config = function()
        local opts = { noremap = true, silent = true }
        -- Define the key mappings
        -- vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua require("omnisharp_extended").lsp_definition()<cr>', opts)
        -- vim.api.nvim_set_keymap('n', 'D', '<cmd>lua require("omnisharp_extended").lsp_type_definition()<cr>', opts)
        -- vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua require("omnisharp_extended").lsp_references()<cr>', opts)
        -- vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua require("omnisharp_extended").lsp_implementation()<cr>', opts)

        -- Telescope variants
        vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua require("omnisharp_extended").telescope_lsp_definition()<cr>',
            opts)
        vim.api.nvim_set_keymap('n', '<leader>D',
            '<cmd>lua require("omnisharp_extended").telescope_lsp_type_definition()<cr>', opts)
        vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua require("omnisharp_extended").telescope_lsp_references()<cr>',
            opts)
        vim.api.nvim_set_keymap('n', 'gi',
            '<cmd>lua require("omnisharp_extended").telescope_lsp_implementations()<cr>', opts)

        --     local config = {
        --         handlers = {
        --             ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
        --             ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
        --             ["textDocument/references"] = require('omnisharp_extended').references_handler,
        --             ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
        --         }
        --     }
        --     require'lspconfig'.omnisharp.setup(config)
    end,
}
