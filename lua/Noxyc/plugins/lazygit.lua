-- LazyGit - лучший Git UI для Neovim
return {
    "kdheepak/lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        { "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit Current File" },
    },
    config = function()
        -- Настройки для LazyGit
        vim.g.lazygit_floating_window_winblend = 0
        vim.g.lazygit_floating_window_scaling_factor = 0.9
        vim.g.lazygit_floating_window_border_chars = {'╭','─', '╮', '│', '╯','─', '╰', '│'}
        vim.g.lazygit_floating_window_use_plenary = 0
        vim.g.lazygit_use_neovim_remote = 1
        vim.g.lazygit_use_custom_config_file_path = 0
    end,
}

