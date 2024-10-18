return {
    "lxvevery1/nvim-cursorline",

    config = function()
        require('nvim-cursorline').setup {
            cursorline = {
                enable = false, -- this is causing really bad performance
                timeout = 10,
                number = false,
            },
            cursorword = {
                enable = true,
                timeout = 100,
                min_length = 3,
                hl = { underline = true },
            },
        }
    end
}
