-- statusline in the bottom-right corner.
return {
    "lxvevery1/nil",

    config = function()
        local icons = {
            spinner = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
            done = ' '
        }

        local clients = {}
        -- Maintain the total number of current windows
        local total_wins = 0

        ---@param callable function
        ---@return boolean # If the callable executes successfully or not
        local function guard(callable)
            local whitelist = {
                "E11: Invalid in command%-line window",
                "E523: Not allowed here",
                'E565: Not allowed to change',
            }
            local ok, err = pcall(callable)
            if ok then
                return true
            end
            if type(err) ~= "string" then
                error(err)
            end
            for _, msg in ipairs(whitelist) do
                if string.find(err, msg) then
                    return false
                end
            end
            error(err)
        end

        -- Initialize or reset the properties of the given client
        local function init_or_reset(client)
            client.is_done = false
            client.spinner_idx = 0
            client.winid = nil
            client.bufnr = nil
            client.message = nil
            client.pos = total_wins + 1
            client.timer = nil
        end

        -- Get the row position of the current floating window. If it is the first one, it is placed just
        -- right above the statuslien; if not, it is placed on top of others.
        local function get_win_row(pos)
            return vim.o.lines - vim.o.cmdheight - 1 - pos * 3
        end

        -- Update the window config
        local function win_update_config(client)
            vim.api.nvim_win_set_config(client.winid, {
                relative = 'editor',
                width = #client.message,
                height = 1,
                row = get_win_row(client.pos),
                col = vim.o.columns - #client.message,
            })
        end

        -- Close the window and delete the associated buffer
        local function close_window(winid, bufnr)
            if vim.api.nvim_win_is_valid(winid) then
                vim.api.nvim_win_close(winid, true)
            end
            if vim.api.nvim_buf_is_valid(bufnr) then
                vim.api.nvim_buf_delete(bufnr, { force = true })
            end
        end

        -- Assemble the output progress message and set the flag to mark if it's completed.
        -- * General: ⣾ [client_name] title: message ( 5%)
        -- * Done:     [client_name] title: DONE!
        local function process_message(client, name, params)
            local message = ''
            message = '[' .. name .. ']'
            local kind = params.value.kind
            local title = params.value.title
            if title then
                message = message .. ' ' .. title .. ':'
            end
            if kind == 'end' then
                client.is_done = true
                message = icons.done .. ' ' .. message .. ' DONE!'
            else
                client.is_done = false
                local raw_msg = params.value.message
                local pct = params.value.percentage
                if raw_msg then
                    message = message .. ' ' .. raw_msg
                end
                if pct then
                    message = string.format('%s (%3d%%)', message, pct)
                end
                -- Spinner
                local idx = client.spinner_idx
                idx = idx == #icons.spinner * 4 and 1 or idx + 1
                message = icons.spinner[math.ceil(idx / 4)] .. ' ' .. message
                client.spinner_idx = idx
            end
            return message
        end

        -- Show the progress message in floating window
        local function show_message(client)
            local winid = client.winid
            -- Create a new window or update the existing one
            if
                winid == nil
                or not vim.api.nvim_win_is_valid(winid)
                or vim.api.nvim_win_get_tabpage(winid) ~= vim.api.nvim_get_current_tabpage() -- Switch to another tab
            then
                local success = guard(function()
                    winid = vim.api.nvim_open_win(client.bufnr, false, {
                        relative = 'editor',
                        width = #client.message,
                        height = 1,
                        row = get_win_row(client.pos),
                        col = vim.o.columns - #client.message,
                        focusable = false,
                        style = 'minimal',
                        noautocmd = true,
                        border = vim.g.border_style,
                    })
                end)
                if not success then
                    return
                end
                client.winid = winid
                total_wins = total_wins + 1
            else
                win_update_config(client)
            end
            -- Write the message into the buffer
            vim.wo[winid].winhl = 'Normal:Normal'
            guard(function()
                vim.api.nvim_buf_set_lines(client.bufnr, 0, 1, false, { client.message })
            end)
        end

        -- Display the progress message
        local function handler(args)
            local client_id = args.data.client_id

            -- Initialize the properties
            if clients[client_id] == nil then
                clients[client_id] = {}
                init_or_reset(clients[client_id])
            end
            local cur_client = clients[client_id]

            -- Create buffer for the floating window showing the progress message and the timer used to close
            -- the window when progress report is done.
            if cur_client.bufnr == nil then
                cur_client.bufnr = vim.api.nvim_create_buf(false, true)
            end
            if cur_client.timer == nil then
                cur_client.timer = vim.uv.new_timer()
            end

            -- Get the formatted progress message
            cur_client.message = process_message(cur_client, vim.lsp.get_client_by_id(client_id).name, args.data.params)

            -- Show progress message in floating window
            show_message(cur_client)

            -- Close the window when finished and adjust the positions of other windows if they exist.
            -- Let the window stay briefly on the screen before closing it (say 2s). When closing, attempt to
            -- close at intervals (say 100ms) to handle the potential textlock. We can use uv.timer to
            -- implement it.
            --
            -- NOTE:
            -- During the waiting period, if it is set for a long duration like 3s, the same server may report
            -- another around of progress notification, and this window will continue to be used for
            -- displaying. When the period is over and an attempt is made to close the window, two possible
            -- scenarios may occur:
            -- 1. the new round of progress notification report has not yet finished, so this window
            --    should not be closed.
            -- 2. the new round of progress notification report has finished. We should avoid the window being
            --    closed twice. In the code below, timer:start() will be called again and it just resets the
            --    timer, so the window will not be closed twice.
            if cur_client.is_done then
                cur_client.timer:start(2000, 100, vim.schedule_wrap(function()
                    -- To handle the scenario 1
                    if not cur_client.is_done and cur_client.winid ~= nil then
                        cur_client.timer:stop()
                        return
                    end
                    local success = false
                    -- Close the window if it has not been closed yet
                    if cur_client.winid ~= nil and cur_client.bufnr ~= nil then
                        success = guard(function()
                            close_window(cur_client.winid, cur_client.bufnr)
                        end)
                    end
                    -- If the window is closed successfully, stop the timer, adjust the positions of other windows
                    -- and reset properties of the client
                    if success then
                        cur_client.timer:stop()
                        cur_client.timer:close()
                        total_wins = total_wins - 1
                        -- Move all windows above this closed window down by one position
                        for _, c in ipairs(clients) do
                            if c.winid ~= nil and c.pos > cur_client.pos then
                                c.pos = c.pos - 1
                                win_update_config(c)
                            end
                        end
                        -- Reset the properties
                        init_or_reset(cur_client)
                    end
                end))
            end
        end

        -- Display the progress message when it comes
        local group = vim.api.nvim_create_augroup('lsp_progress', { clear = true })
        vim.api.nvim_create_autocmd({ 'LspProgress' }, {
            group = group,
            pattern = '*',
            callback = function(args)
                handler(args)
            end,
        })

        -- Update windows.
        -- 1. VimResized: When the server finishes reporting the progress notification, I have the window
        --    stayed on screen for a few seconds, however, the window (such as its position) won't be
        --    updated any more in LspProgress event. When the terminal window is resized, windows of this
        --    kind need to be updated.
        -- 2. TermLeave: It's for fzf.vim and it's so weird. Take the golang server as an example, it only
        --    send two progress notifications, 'begin' kind and 'end' kind. After we open a golang file,
        --    firstly a floating window will be created showing the message of the first progress
        --    notification (i.e., 'begin' kind). Let's say the window width is 53. Meanwhile, we open a
        --    fzf.vim window. At this point, that floating window has already displayed the message of the
        --    second progress notification (i.e., 'end' kind) and it will stay on the screen for a few
        --    seconds before it is closed. Let's say its width is 35. Now we quite the fzf.vim window. We
        --    can see that the width of the floating window is changed back to 53, i.e., reverting to the
        --    width when displaying the first message before that fzf.vim window was opened. THIS IS SO
        --    WEIRD! So use this autocmd to set the floating window back to 35.
        vim.api.nvim_create_autocmd({ 'VimResized', 'TermLeave' }, {
            group = group,
            pattern = '*',
            callback = function()
                for _, c in ipairs(clients) do
                    if c.is_done then
                        win_update_config(c)
                    end
                end
            end,
        })
    end
}
