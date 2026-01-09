return {
    "mbbill/undotree",

    config = function()
        vim.keymap.set('n', '<F3>', vim.cmd.UndotreeToggle)
    end,
}
