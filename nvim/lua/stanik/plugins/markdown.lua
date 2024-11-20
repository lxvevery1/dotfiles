return {
    "MeanderingProgrammer/markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },

    ft = { "md", "markdown" },
    config = function()
        require('render-markdown').setup(
            {
                latex =
                {
                    enable = false
                },
                highlight = {
                    enable = true
                }
            })
    end,
}
