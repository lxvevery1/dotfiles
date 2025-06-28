return {
    "apyra/nvim-unity-sync",
    config = function()
        require("unity.plugin").setup({
            unity_path = "/home/stanik/unity/hub/editor/6000.1.3f1/Editor ", -- Optional, to run the :Uopen command
            unity_cs_template = true
        })
    end,
    ft = "cs",
}
