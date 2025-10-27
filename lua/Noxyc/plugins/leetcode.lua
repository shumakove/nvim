return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    lang = "python3", -- можно: cpp / python3 / java / go / rust / ts
    -- storage = { home = vim.fn.stdpath("data") .. "/leetcode", cache = vim.fn.stdpath("cache") .. "/leetcode" },
    -- image_support = true, -- включи, если нужен вывод картинок (kitty/ueberzug)
  },
  keys = {
    { "<leader>ll", "<cmd>LeetCode list<cr>",   desc = "LeetCode List" },
    { "<leader>lp", "<cmd>LeetCode pick<cr>",   desc = "LeetCode Pick" },
    { "<leader>lr", "<cmd>LeetCode run<cr>",    desc = "LeetCode Run" },
    { "<leader>ls", "<cmd>LeetCode submit<cr>", desc = "LeetCode Submit" },
  },
}
