return {
    "MeanderingProgrammer/markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },

    config = function()
        require('render-markdown').setup(
            {
                enabled = false,
                latex = {
                    enable = false
                },
                highlight = {
                    enable = true
                }
            })
    end,
}
