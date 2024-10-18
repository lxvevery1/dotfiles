return {
    "Johanw123/avalonia.nvim",
    config = function()
        -- Настройка автокоманды для .axaml файлов
        vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
            pattern = { "*.axaml", "*.xaml" },
            callback = function()
                vim.cmd.setfiletype("xml") -- Устанавливает тип файла как xml
                vim.lsp.start({
                    name = "Avalonia LSP",
                    cmd = { "dotnet", "/home/stanik/.vscode-oss/extensions/avaloniateam.vscode-avalonia-0.0.31/avaloniaServer/AvaloniaLanguageServer.dll" }, -- Укажите правильный путь к вашему Avalonia LSP серверу
                    root_dir = vim.fn.getcwd(),                                                                                                              -- Определяет корневую директорию проекта
                })
            end,
        })
    end,
}
