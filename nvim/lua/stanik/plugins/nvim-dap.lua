-- Debug adapter plug-in. Debug anything in Neovim
return
{
    "mfussenegger/nvim-dap",
    config = function()
        local dap = require("dap")
        dap.adapters.gdb = {
            type = "executable",
            command = "gdb",
            args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
        }
    end,

    lazy = true,
}
