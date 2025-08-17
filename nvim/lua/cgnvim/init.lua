---@diagnostic disable: undefined-field
-- keep this at the top
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------------------
-- LAZYNVIM PLUGIN MANAGER
-----------------------------
-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    spec = {
        { import = "cgnvim.plugins" },
    },
    checker = { enabled = false },
    ui = {
        border = "single",
    },
})
if vim.loader then
    vim.loader.enable()
end

-----------------------------
-- GLOBAL SETTINGS
-----------------------------
for _, source in ipairs({
    "cgnvim.gsettings",
    "cgnvim.gmappings",
    "cgnvim.gautocmds",
    "cgnvim.gusercmds",
}) do
    local status_ok, error_object = pcall(require, source)
    if not status_ok then
        vim.notify("failed to load: " .. source .. "\n\n" .. error_object, vim.log.levels.ERROR)
    end
end

-----------------------------
-- LSPs INITIALIZATION
-----------------------------
-- default (i.e., inherited by all) LSP config
vim.lsp.config("*", {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    root_markers = { ".git" },
    on_error = function(code, err)
        vim.notify(vim.lsp.rpc.client_errors[code] .. err, vim.log.levels.ERROR)
    end,
})
-- virtual lines and virtual text diagnostics
vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
})
vim.keymap.set('n', '<leader>dd', function()
    vim.diagnostic.open_float(nil, {
        scope = "line",
        border = "rounded",
        header = "Diagnostics",
        focusable = false
    })
end, { noremap = true, silent = true, nowait = true })
-- enable inlay hints
vim.lsp.inlay_hint.enable(true)
-- add LSPs to ignore here (same name as in ./lsps/ folder without the .lua extension)
local lsp_ignore = {}
-- load LSPs defined in ./lsps/ folder
local p = vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "cgnvim", "lsps")
for lsp_name, _ in vim.fs.dir(p) do
    local status_ok, error_object = pcall(function()
        local lsp_id = lsp_name:gsub("%.lua", "")
        if lsp_ignore[lsp_id] == nil then
            local lsp_config = require("cgnvim.lsps." .. lsp_id)
            vim.lsp.config(lsp_id, lsp_config)
            vim.lsp.enable(lsp_id)
        end
    end)
    if not status_ok then
        vim.notify("failed to load LSP: " .. lsp_name .. "\n\n" .. "Reason: " .. error_object, vim.log.levels.ERROR)
    end
end

local builtin = require("telescope.builtin")

-- override default LSP references keymap
vim.keymap.set("n", "gr", builtin.lsp_references, { noremap = true, silent = true, desc = "LSP References (Telescope)" })
-----------------------------
-- DAPs INITIALIZATION
-----------------------------
-- load DAPs defined in ./daps/ folder
for da, _ in vim.fs.dir(vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "cgnvim", "daps")) do
    local status_ok, error_object = pcall(require, "cgnvim.daps." .. da:gsub("%.lua", ""))
    if not status_ok then
        vim.notify("failed to load DAP: " .. da .. "\n\n" .. "Reason: " .. error_object, vim.log.levels.ERROR)
    end
end
-- ======================
-- Encoding
-- ======================
vim.scriptencoding = "utf-8"

-- ======================
-- Filetype, syntax
-- ======================
vim.cmd([[filetype plugin indent on]])
vim.cmd([[syntax on]])

-- ======================
-- Keymaps
-- ======================
local map = vim.keymap.set

-- Visual mode clipboard
map("v", "<C-c>", '"+yi')
map("v", "<C-x>", '"+c')
map("v", "<C-v>", 'c<ESC>"+p')
map("i", "<C-v>", "<C-r><C-o>+")

-- Delete word under cursor, select all, toggle hlsearch
map("n", "<A-w>", "diw")
map("n", "<C-a>", "ggVG")
map("n", "<F4>", ":set hlsearch!<CR>")

-- Move cursor with line (scrolling)
map("n", "<C-S-E>", "j<C-E>")
map("n", "<C-S-Y>", "k<C-Y>")

-- Navigate splits
map("n", "<C-k>", "<Cmd>wincmd k<CR>", { silent = true })
map("n", "<C-j>", "<Cmd>wincmd j<CR>", { silent = true })
map("n", "<C-h>", "<Cmd>wincmd h<CR>", { silent = true })
map("n", "<C-l>", "<Cmd>wincmd l<CR>", { silent = true })

-- Move lines
map("n", "<C-S-J>", ":m+1<CR>", { silent = true })
map("n", "<C-S-K>", ":m-2<CR>", { silent = true })

-- Toggle foldlevel
map("n", "<C-F>", ":if &foldlevel == 1 | set foldlevel=99 | else | set foldlevel=1 | endif<CR>")

-- ======================
-- Commands
-- ======================
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("Wa", "wa", {})
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("CopyFilePath", function()
    vim.fn.setreg("+", vim.fn.expand("%:p"))
end, {})

-- Command abbreviations
vim.cmd([[cnoreabbrev W w]])

-- ======================
-- Leader and cursor
-- ======================
vim.g.mapleader = " "
vim.cmd([[let &t_SI="\e[6 q"]])
vim.cmd([[let &t_EI="\e[2 q"]])

-- ======================
-- Autogroups
-- ======================
vim.api.nvim_create_augroup("myCmds", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
    group = "myCmds",
    command = [[silent !echo -ne "\e[2 q"]],
})

-- ======================
-- Functions
-- ======================
function TrimWhitespace()
    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.cmd([[%s/\($\n\s*\)\+\%$//e]])
    vim.fn.winrestview(view)
end

function Preserve(command)
    local search = vim.fn.getreg("/")
    local cursor_position = vim.fn.getpos(".")
    vim.cmd("normal! H")
    local window_position = vim.fn.getpos(".")
    vim.fn.setpos(".", cursor_position)
    vim.cmd(command)
    vim.fn.setreg("/", search)
    vim.fn.setpos(".", window_position)
    vim.cmd("normal! zt")
    vim.fn.setpos(".", cursor_position)
end

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = TrimWhitespace,
})

-- ======================
-- Options
-- ======================
local o = vim.o
o.number = true
o.relativenumber = true
o.list = true
o.cursorline = true
o.hlsearch = true
o.mouse = "a"
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.ruler = true
o.rulerformat = "%l::%v"
o.backspace = "indent,eol,start"
o.wrapscan = true
o.ttimeout = true
o.ttimeoutlen = 1
o.ttyfast = true
o.clipboard = "unnamedplus"
o.whichwrap = "h,l"
o.foldmethod = "marker"
o.foldmarker = "{,}"
o.foldlevelstart = 99

-- ======================
-- Wayland clipboard
-- ======================
map(
    "x",
    "<leader>y",
    'y:call system("wl-copy --trim-newline", @*)<CR>:call system("wl-copy -p --trim-newline", @*)<CR>',
    { silent = true }
)

-- ======================
-- Highlights
-- ======================
vim.cmd([[
hi Normal guibg=NONE ctermbg=NONE
hi ColorColumn ctermbg=red ctermfg=black
hi Comment cterm=italic
hi CursorLine cterm=bold ctermbg=NONE ctermfg=NONE
hi CursorLineNr cterm=bold ctermbg=NONE ctermfg=NONE
hi DiffAdd cterm=bold ctermbg=blue ctermfg=black
hi DiffChange cterm=bold ctermbg=225 ctermfg=black
hi DiffDelete cterm=bold ctermbg=159 ctermfg=black
hi Error ctermbg=red ctermfg=black
hi ErrorMsg ctermbg=red ctermfg=black
hi LineNr ctermfg=darkblue
hi Search cterm=bold ctermbg=yellow ctermfg=black
hi SignColumn cterm=standout ctermbg=white ctermfg=black
hi SpellBad cterm=underline ctermbg=NONE ctermfg=red
hi SpellLocal cterm=reverse ctermbg=black
hi SpellCap cterm=bold ctermbg=NONE ctermfg=blue
hi SpellRare cterm=reverse ctermbg=darkblue
hi Pmenu ctermbg=0 ctermfg=15
hi MatchParen cterm=bold ctermbg=black ctermfg=white
hi link YcmWarningText SpellCap
]])
