return {
    "lxvevery1/harpoon2",
    branch = "harpoon2",
    requires = { { "nvim-lua/plenary.nvim" } },
    opts = function()
        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end,
            { desc = "Add opened file to the buffer list" })

        -- Define a function to set up keymaps for Harpoon buffer navigation
        local function setup_harpoon_keymaps()
            for i = 1, 10 do
                vim.keymap.set("n", "<M-" .. (i % 10) .. ">", function()
                    harpoon:list():select(i)
                end, { desc = "Go to item " .. i .. " in buffer list" })
            end
        end

        setup_harpoon_keymaps()

        -- use default item picker
        vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    end
}
