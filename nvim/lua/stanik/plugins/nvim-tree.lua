return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",

    config = function()
        local nvimtree = require("nvim-tree")
        -- disable netrw at the very start of your init.lua
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- optionally enable 24-bit colour
        vim.opt.termguicolors = true

        nvimtree.setup({
            filters = {
                -- ignore .meta file extension (for unity development)
                custom = { 'meta' },
            }
        })

        vim.api.nvim_set_keymap('n', '<C-t>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
    end
}
