-- Neo-tree - Файловый менеджер с боковой панелью (как в Cursor IDE)
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
        { "<leader>e", "<cmd>Neotree toggle left<cr>", desc = "Toggle File Explorer" },
        { "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Reveal Current File" },
    },
    opts = {
        -- Автоматически открывать при запуске nvim с директорией
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
        
        filesystem = {
            follow_current_file = {
                enabled = true, -- Автоматически показывать текущий файл
                leave_dirs_open = true,
            },
            hijack_netrw_behavior = "open_default", -- Заменить netrw
            use_libuv_file_watcher = true, -- Автообновление при изменениях
            filtered_items = {
                visible = true, -- Показывать скрытые файлы
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_by_name = {
                    "node_modules",
                    ".git",
                    ".DS_Store",
                },
                never_show = {
                    ".DS_Store",
                },
            },
        },
        
        window = {
            position = "left",
            width = 35, -- Ширина панели
            mapping_options = {
                noremap = true,
                nowait = true,
            },
            mappings = {
                ["<space>"] = {
                    "toggle_node",
                    nowait = false,
                },
                ["<cr>"] = "open",
                ["<esc>"] = "cancel",
                ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
                ["l"] = "open",
                ["h"] = "close_node",
                ["z"] = "close_all_nodes",
                ["Z"] = "expand_all_nodes",
                ["a"] = {
                    "add",
                    config = {
                        show_path = "none",
                    },
                },
                ["A"] = "add_directory",
                ["d"] = "delete",
                ["r"] = "rename",
                ["y"] = "copy_to_clipboard",
                ["x"] = "cut_to_clipboard",
                ["p"] = "paste_from_clipboard",
                ["c"] = "copy",
                ["m"] = "move",
                ["q"] = "close_window",
                ["R"] = "refresh",
                ["?"] = "show_help",
                ["<"] = "prev_source",
                [">"] = "next_source",
                ["i"] = "show_file_details",
            },
        },
        
        default_component_configs = {
            indent = {
                indent_size = 2,
                padding = 1,
                with_markers = true,
                indent_marker = "│",
                last_indent_marker = "└",
                highlight = "NeoTreeIndentMarker",
            },
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "",
                default = "*",
                highlight = "NeoTreeFileIcon",
            },
            modified = {
                symbol = "[+]",
                highlight = "NeoTreeModified",
            },
            name = {
                trailing_slash = false,
                use_git_status_colors = true,
                highlight = "NeoTreeFileName",
            },
            git_status = {
                symbols = {
                    added     = "✚",
                    modified  = "",
                    deleted   = "✖",
                    renamed   = "󰁕",
                    untracked = "",
                    ignored   = "",
                    unstaged  = "󰄱",
                    staged    = "",
                    conflict  = "",
                },
            },
        },
        
        -- Автоматически открывать при запуске nvim с директорией
        event_handlers = {
            {
                event = "file_opened",
                handler = function(file_path)
                    -- Оставляем neo-tree открытым после открытия файла
                    require("neo-tree.command").execute({ action = "show" })
                end
            },
        },
    },
    
    config = function(_, opts)
        require("neo-tree").setup(opts)
        
        -- Автоматически открывать neo-tree при запуске nvim с директорией
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function(data)
                -- Проверяем что открыли директорию
                local directory = vim.fn.isdirectory(data.file) == 1
                
                if directory then
                    -- Открываем neo-tree
                    vim.cmd("Neotree show left")
                    -- Фокус на первом окне (файлы)
                    vim.cmd("wincmd p")
                end
            end,
        })
    end,
}


