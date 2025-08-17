return {
    "lxvevery1/harpoon2",
    branch = "harpoon2",
    requires = { { "nvim-lua/plenary.nvim" } },
    opts = function()
        return require("cgnvim.configs.harpoon")
    end
}
