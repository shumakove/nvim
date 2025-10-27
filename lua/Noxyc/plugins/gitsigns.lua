-- GitSigns - показывает изменения в коде + Git blame
return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add          = { text = '▎' },
            change       = { text = '▎' },
            delete       = { text = '' },
            topdelete    = { text = '' },
            changedelete = { text = '▎' },
            untracked    = { text = '▎' },
        },
        signs_staged = {
            add          = { text = '▎' },
            change       = { text = '▎' },
            delete       = { text = '' },
            topdelete    = { text = '' },
            changedelete = { text = '▎' },
        },
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Навигация по изменениям (hunks)
            map('n', ']h', function()
                if vim.wo.diff then return ']h' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { expr = true, desc = "Next Git hunk" })

            map('n', '[h', function()
                if vim.wo.diff then return '[h' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, { expr = true, desc = "Previous Git hunk" })

            -- Действия с изменениями
            map('n', '<leader>hs', gs.stage_hunk, { desc = "Stage hunk" })
            map('n', '<leader>hr', gs.reset_hunk, { desc = "Reset hunk" })
            map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage hunk" })
            map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset hunk" })
            map('n', '<leader>hS', gs.stage_buffer, { desc = "Stage buffer" })
            map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Undo stage hunk" })
            map('n', '<leader>hR', gs.reset_buffer, { desc = "Reset buffer" })
            map('n', '<leader>hp', gs.preview_hunk, { desc = "Preview hunk" })
            map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = "Blame line" })
            map('n', '<leader>hB', gs.toggle_current_line_blame, { desc = "Toggle line blame" })
            map('n', '<leader>hd', gs.diffthis, { desc = "Diff this" })
            map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Diff this ~" })

            -- Text object для изменений
            map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select hunk" })
        end,
        current_line_blame = false, -- Показывать blame для текущей строки
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol',
            delay = 500,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        preview_config = {
            border = 'rounded',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
        watch_gitdir = {
            interval = 1000,
            follow_files = true
        },
        attach_to_untracked = true,
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
    },
}

