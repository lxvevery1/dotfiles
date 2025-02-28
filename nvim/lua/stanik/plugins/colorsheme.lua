return {
    'ashen-org/ashen.nvim',
    priority = 1000, -- Laod this plugin as first
    config = function()
        -- vim.o.background = 'dark'
        vim.cmd('colorscheme ashen')

        -- transparent bg
        vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
    end,
}
