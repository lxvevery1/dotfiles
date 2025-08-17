return {
  "lxvevery1/alduin.nvim",
  priority = 1000, -- Laod this plugin as first
  config = function()
    require("alduin").setup({
      bold = {
        property = false,
        funcs = true,
      },
    })

    vim.cmd("let g:alduin_Shout_Become_Ethereal = 1")

    vim.cmd("colorscheme alduin")

    vim.cmd([[
            hi Normal       guibg=NONE ctermbg=NONE
            hi NormalNC     guibg=NONE ctermbg=NONE
            hi EndOfBuffer  guibg=NONE ctermbg=NONE
            hi VertSplit    guibg=NONE ctermbg=NONE
            hi SignColumn   guibg=NONE ctermbg=NONE
            hi LineNr       guibg=NONE ctermbg=NONE
            hi FoldColumn   guibg=NONE ctermbg=NONE
            hi StatusLine   guibg=NONE ctermbg=NONE
            hi TabLineFill  guibg=NONE ctermbg=NONE
        ]])
  end,
}
