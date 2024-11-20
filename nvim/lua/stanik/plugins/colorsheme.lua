return {
    'ellisonleao/gruvbox.nvim',
    priority = 1000, -- Laod this plugin as first

    config = function()
        require("gruvbox").setup({
            terminal_colors = false, -- add neovim terminal colors
            undercurl = true,
            underline = true,
            bold = false,
            italic = {
                strings = true,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true,    -- invert background for search, diffs, statuslines and errors
            contrast = "soft", -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false,
        })
        vim.o.background = 'dark'
        vim.cmd('colorscheme gruvbox')

        -- transparent bg
        vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
    end,
}
