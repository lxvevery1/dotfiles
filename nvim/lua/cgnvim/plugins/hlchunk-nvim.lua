return {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },

    config = function()
        require('hlchunk').setup({
            chunk = {
                enable = true,

                error_sign = true,
                use_treesitter = false,

                -- color related
                style = {
                    { fg = "#7c6f64" },
                    { fg = "#c21f30" },
                },
                -- animation related
                delay = 100,
                duration = 80,
            },
            indent = {
                enable = true
                -- ...
            }
        })
    end
}
