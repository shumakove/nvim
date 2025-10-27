-- DiffView - мощный просмотр диффов и истории
return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
        "DiffviewOpen",
        "DiffviewClose",
        "DiffviewToggleFiles",
        "DiffviewFocusFiles",
        "DiffviewRefresh",
        "DiffviewFileHistory",
    },
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView Open" },
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
        { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch History" },
        { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "DiffView Close" },
    },
    opts = {
        enhanced_diff_hl = true,
        view = {
            default = {
                layout = "diff2_horizontal",
                winbar_info = true,
            },
            merge_tool = {
                layout = "diff3_mixed",
            },
            file_history = {
                layout = "diff2_horizontal",
                winbar_info = true,
            },
        },
        file_panel = {
            listing_style = "tree",
            tree_options = {
                flatten_dirs = true,
                folder_statuses = "only_folded",
            },
            win_config = {
                position = "left",
                width = 35,
            },
        },
        file_history_panel = {
            log_options = {
                git = {
                    single_file = {
                        diff_merges = "combined",
                    },
                    multi_file = {
                        diff_merges = "first-parent",
                    },
                },
            },
            win_config = {
                position = "bottom",
                height = 16,
            },
        },
        commit_log_panel = {
            win_config = {},
        },
        default_args = {
            DiffviewOpen = {},
            DiffviewFileHistory = {},
        },
        hooks = {},
        keymaps = {
            disable_defaults = false,
            view = {
                ["<tab>"]      = false,
                ["<s-tab>"]    = false,
                ["gf"]         = false,
                ["<C-w><C-f>"] = false,
                ["<C-w>gf"]    = false,
                ["q"]          = "<cmd>DiffviewClose<cr>",
                ["<leader>e"]  = false,
                ["<leader>b"]  = false,
                ["[x"]         = false,
                ["]x"]         = false,
            },
            file_panel = {
                ["j"]             = false,
                ["k"]             = false,
                ["<cr>"]          = false,
                ["o"]             = false,
                ["<2-LeftMouse>"] = false,
                ["-"]             = false,
                ["<tab>"]         = false,
                ["i"]             = false,
                ["f"]             = false,
                ["R"]             = false,
                ["L"]             = false,
                ["gf"]            = false,
                ["<C-w><C-f>"]    = false,
                ["<C-w>gf"]       = false,
                ["q"]             = "<cmd>DiffviewClose<cr>",
            },
            file_history_panel = {
                ["g!"]            = false,
                ["<C-A-d>"]       = false,
                ["y"]             = false,
                ["L"]             = false,
                ["q"]             = "<cmd>DiffviewClose<cr>",
            },
        },
    },
}

