---@diagnostic disable: param-type-mismatch

---@class PyrightInitializeResult: lsp.InitializeResult

return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        ".git",
    },
    settings = {
        python = {
            analysis = {
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace", -- or "openFilesOnly"
                typeCheckingMode = "basic",   -- or "strict" / "off"
            },
        },
    },
    ---@param client vim.lsp.Client
    ---@param init_result PyrightInitializeResult
    on_init = function(client, init_result)
        -- Можно что-то настроить при инициализации, как в clangd-конфиге
        vim.notify("Pyright initialized for " .. client.name)
    end,
    on_attach = function(_, bufnr)
        -- Кастомные команды, если хочешь (пример)
        vim.api.nvim_buf_create_user_command(
            bufnr,
            "LspPyrightOrganizeImports",
            function()
                vim.lsp.buf.execute_command({
                    command = "pyright.organizeimports",
                    arguments = { vim.api.nvim_buf_get_name(bufnr) },
                })
            end,
            { desc = "Organize Python imports with Pyright" }
        )
    end,
}
