-- Debug adapter plug-in. Debug anything in Neovim
return {
    "mfussenegger/nvim-dap",
    config = function()
        local dap = require("dap")

        -- Define the LLDB adapter
        dap.adapters.lldb = {
            type = 'executable',
            command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
            name = 'lldb'
        }

        -- Define the configurations for LLDB
        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "lldb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
                runInTerminal = false,
            },
        }

        -- Define key mappings
        vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end,
            { desc = "Toggle breakpoint" })
        vim.keymap.set('n', '<leader>dr', function() require('dap').continue() end,
            { desc = "Start or continue debugger" })
    end,
}
