return {
    "MeanderingProgrammer/markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },

    ft = { "md", "markdown" },
    config = function ()
        require('render-markdown').setup({})
    end,
}
