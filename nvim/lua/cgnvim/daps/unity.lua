--[[DAP configuration that allows Neovim DAP client to attach to a running
Unity Player instance.]]

local dap = require("dap")

dap.adapters.unity = function(cb, config)
    -- options passed to unity-debug-adapter.exe

    -- when connecting to a running Unity Editor, the TCP address of the listening connection is localhost
    -- on Linux, use: ss -tlp | grep 'Unity' to find the debugger connection
    vim.ui.input({ prompt = "address [127.0.0.1]: ", default = "127.0.0.1" }, function(result)
        config.address = result
    end)
    vim.ui.input({ prompt = "port: " }, function(result)
        config.port = tonumber(result)
    end)
    cb({
        type = "executable",
        -- adjust mono path - do not use Unity's integrated MonoBleedingEdge
        command = "mono",
        -- adjust unity-debug-adapter.exe path
        args = {
            -- get Unity debug adapter from: https://github.com/walcht/unity-dap
            "/home/stanik/downloads/netcore_debug_adapter/netcoredbg/netcoredbg",
            "--interpreter=vscode",
            -- optional log level argument: trace | debug | info | warn | error | critical | none
            "--log-level=warn",
            -- optional path to log file (logs to stderr in case this is not provided)
            -- "--log-file=<path-to-log-file.txt>",
        },
    })
end

-- make sure not to override other C# DAP configurations
if dap.configurations.cs == nil then
    dap.configurations.cs = {}
end

table.insert(dap.configurations.cs, {
    name = "Unity Editor/Player Instance [Mono]",
    type = "unity",
    request = "attach",
})

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<F5>", dap.continue, opts)
vim.keymap.set("n", "<F10>", dap.step_over, opts)
vim.keymap.set("n", "<F11>", dap.step_into, opts)
vim.keymap.set("n", "<F12>", dap.step_out, opts)

vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, opts)
vim.keymap.set("n", "<Leader>B", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, opts)

vim.keymap.set("n", "<Leader>lp", function()
    dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, opts)

vim.keymap.set("n", "<Leader>dr", dap.repl.open, opts)
vim.keymap.set("n", "<Leader>dl", dap.run_last, opts)
