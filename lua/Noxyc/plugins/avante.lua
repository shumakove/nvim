-- Avante.nvim - Альтернативный AI-ассистент с UI похожим на Cursor
-- Используйте если хотите sidebar-интерфейс вместо chat
return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    enabled = false, -- Включить после настройки (опционально, CodeCompanion уже активен)
    build = "make",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        provider = "claude",
        claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-3-5-sonnet-20241022",
            temperature = 0,
            max_tokens = 8192,
        },
        behaviour = {
            auto_suggestions = true,
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
        },
        mappings = {
            ask = "<leader>aa",
            edit = "<leader>ae",
            refresh = "<leader>ar",
        },
        windows = {
            wrap = true,
            width = 30,
        },
    },
}

