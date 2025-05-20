return {
    "AlessandroYorba/Alduin",
    priority = 1000, -- Laod this plugin as first
    config = function()
        -- vim.o.background = 'dark'
        vim.cmd('let g:alduin_Shout_Become_Ethereal = 1')
        vim.cmd('colorscheme alduin')
        -- transparent bg
        -- vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
    end,
}
