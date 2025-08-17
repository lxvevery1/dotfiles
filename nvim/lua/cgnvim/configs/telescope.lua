local telescope = require("telescope")
local actions = require("telescope.actions")
local transform_mod = require("telescope.actions.mt").transform_mod

local trouble = require("trouble")
local trouble_telescope = require("trouble.sources.telescope")

-- or create your custom action
local custom_actions = transform_mod({
    open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
    end,
})

local ignore_filetypes_list = {
    "venv", "__pycache__", "%.xlsx", "%.jpg", "%.png", "%.webp", "%.pdf", "%.odt", "%.ico", -- default
    "%.meta", "%.asmdef", "%.asset"                                                         -- unity
}

local funcs_symb = { "Function", "Method" }
local var_symb = { "Property", "Field" }

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ss", function()
    builtin.lsp_document_symbols()
end, { desc = "Find symbols in current file" })

vim.keymap.set("n", "<leader>sS", function()
    builtin.lsp_workspace_symbols()
end, { desc = "Find symbols in workspace" })

vim.keymap.set("n", "<leader>sf", function()
    builtin.lsp_document_symbols({ symbols = funcs_symb })
end, { desc = "Find functions in current file" })

vim.keymap.set("n", "<leader>sF", function()
    builtin.lsp_workspace_symbols({ symbols = funcs_symb })
end, { desc = "Find functions in workspace" })

vim.keymap.set("n", "<leader>sv", function()
    builtin.lsp_document_symbols({ symbols = var_symb })
end, { desc = "Find properties and variables in current file" })

vim.keymap.set("n", "<leader>sV", function()
    builtin.lsp_workspace_symbols({ symbols = var_symb })
end, { desc = "Find properties and variables in workspace" })

vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = "LSP References" })

telescope.setup({
    defaults = {
        path_display = { "truncate" },
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                ["<C-j>"] = actions.move_selection_next,     -- move to next result
                ["<C-q>"] = actions.send_to_qflist + custom_actions.open_trouble_qflist,
                ["<C-S-t>"] = trouble_telescope.open,
            },
        },
        file_ignore_patterns = ignore_filetypes_list,
        layout_strategy = "horizontal",
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    },
    extensions = {
        fzf = {
            fuzzy = true, -- enable fuzzy
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case", -- "smart_case" | "ignore_case" | "respect_case"
        }
    },
})

telescope.load_extension("fzf")

-- set keymaps
local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
keymap.set("n", "<leader>fe", "<cmd>Telescope diagnostics<cr>", { desc = "List of warnings/errors in project" })
keymap.set("n", "<leader>fw", "<cmd>Telescope diagnostics<cr>", { desc = "List of warnings/errors in project" })
keymap.set("n", "<leader>xQ", "<cmd>Trouble quickfix<cr>", { desc = "Open old quickfix window" })
