return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
    },
    config = function()
        -- import lspconfig plugin
        local lspconfig = require("lspconfig")

        -- import mason_lspconfig plugin
        local mason_lspconfig = require("mason-lspconfig")

        -- import cmp-nvim-lsp plugin
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap -- for conciseness

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true }

                -- set keybinds
                opts.desc = "Show LSP references"
                keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

                opts.desc = "Go to declaration"
                keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = "Show LSP definitions"
                keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

                opts.desc = "Show LSP implementations"
                keymap.set("n", "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show diagnostics for file

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

                opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>lr", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
            end,
        })

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Change the Diagnostic symbols in the sign column (gutter)
        -- (not in youtube nvim video)
        local signs = { Error = " ", Warn = "⚠", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        mason_lspconfig.setup_handlers({
            -- default handler for installed servers
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
            end,
            ["clangd"] = function()
                -- configure clangd language server
                lspconfig["clangd"].setup({
                    capabilities = capabilities,
                    filetypes = { "c", "cpp", "h", "hpp", "objc", "objcpp", "cuda", "proto", "ipp" },
                })
            end,
            ["omnisharp"] = function()
                -- configure omnisharp language server
                local path_to_download1 = '/home/stanik/.cache/omnisharp-vim/omnisharp-roslyn/OmniSharp'
                local path_to_download2 = '/home/stanik/.cache/omnisharp-vim/OmniSharp/omnisharp/OmniSharp.exe'
                lspconfig["omnisharp"].setup({
                    cmd = {
                        "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll"
                    },
                    root_dir = lspconfig.util.root_pattern("*.sln"),
                    capabilities = {
                        didChangeWatchedFiles = {
                            dynamicRegistration = true,
                        },
                    },
                    filetypes = { "cs" },

                    -- Enables support for reading code style, naming convention and analyzer
                    -- settings from .editorconfig.
                    enable_editorconfig_support = true,

                    -- If true, MSBuild project system will only load projects for files that
                    -- were opened in the editor. This setting is useful for big C# codebases
                    -- and allows for faster initialization of code navigation features only
                    -- for projects that are relevant to code that is being edited. With this
                    -- setting enabled OmniSharp may load fewer projects and may thus display
                    -- incomplete reference lists for symbols.
                    enable_ms_build_load_projects_on_demand = true,

                    -- Enables support for roslyn analyzers, code fixes and rulesets.
                    enable_roslyn_analyzers = true,

                    -- Specifies whether 'using' directives should be grouped and sorted during
                    -- document formatting.
                    organize_imports_on_format = true,

                    -- Enables support for showing unimported types and unimported extension
                    -- methods in completion lists. When committed, the appropriate using
                    -- directive will be added at the top of the current file. This option can
                    -- have a negative impact on initial completion responsiveness,
                    -- particularly for the first few completion sessions after opening a
                    -- solution.
                    enable_import_completion = true,

                    -- Specifies whether to include preview versions of the .NET SDK when
                    -- determining which version to use for project loading.
                    sdk_include_prereleases = true,

                    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
                    -- true
                    analyze_open_documents_only = false,
                })
                local function checktime_if_not_command_mode()
                    if vim.api.nvim_get_mode().mode ~= 'c' then
                        vim.cmd('checktime')
                    end
                end

                -- Создание автокоманды
                vim.api.nvim_create_autocmd(
                {'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI'}, -- События
                {
                    pattern = '*', -- Шаблон для файлов (здесь - все файлы)
                    callback = checktime_if_not_command_mode -- Функция обратного вызова
                })
            end,
            ["lua_ls"] = function()
                -- configure lua server (with special settings)
                lspconfig["lua_ls"].setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            -- make the language server recognize "vim" global
                            diagnostics = {
                                globals = { "vim" },
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                })
            end,
            ["rust_analyzer"] = function()
                lspconfig["rust_analyzer"].setup({
                    capabilities = capabilities,
                    settings = {
                        ['rust_analyzer'] = {
                            diagnostics = {
                                enable = true;
                            },
                        },
                    },
                })
            end,
        })
    end
}
