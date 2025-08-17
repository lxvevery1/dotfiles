return {
    on_attach = function(bufnr)
        local m = vim.keymap.set
        local gitsigns = require("gitsigns")

        local nav_next = function()
            if vim.wo.diff then
                vim.cmd.normal({ "]h", bang = true })
            else
                gitsigns.nav_hunk("next")
            end
        end

        local nav_prev = function()
            if vim.wo.diff then
                vim.cmd.normal({ "[h", bang = true })
            else
                gitsigns.nav_hunk("prev")
            end
        end

        m("n", "]h", nav_next, { buffer = bufnr, desc = "navigate to (])next (h)unk" })
        m("n", "[h", nav_prev, { buffer = bufnr, desc = "navigate to ([)prev (h)unk" })
        m("n", "<leader>gtsh", gitsigns.stage_hunk, { buffer = bufnr, desc = "(g)it (s)tage (h)unk" })
        m("n", "<leader>gtrh", gitsigns.reset_hunk, { buffer = bufnr, desc = "(g)it (r)eset (h)unk" })
        m("v", "<leader>gtsh", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { buffer = bufnr, desc = "(g)it (s)tage (h)unk" })
        m("v", "<leader>gtrh", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { buffer = bufnr, desc = "(g)it (r)eset (h)unk" })
        m("n", "<leader>gtsb", gitsigns.stage_buffer, { buffer = bufnr, desc = "(g)it (s)tage (b)uffer" })
        m("n", "<leader>gtrb", gitsigns.reset_buffer, { buffer = bufnr, desc = "(g)it (r)eset (b)uffer" })
        m("n", "<leader>gtph", gitsigns.preview_hunk_inline, { buffer = bufnr, desc = "(g)it (p)review (h)unk" })
        m("n", "<leader>gtdv", gitsigns.diffthis, { buffer = bufnr, desc = "(g)it (d)iff (v)iew" })
        m("n", "<leader>gttb", gitsigns.toggle_current_line_blame, {
            buffer = bufnr,
            desc = "(g)it (t)oggle current line (b)lame",
        })
    end,
}
