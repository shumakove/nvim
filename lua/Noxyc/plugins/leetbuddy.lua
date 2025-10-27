return {
  "Dhanus3133/LeetBuddy.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  cookie_file = vim.fn.stdpath("config") .. "/leetbuddy.json",
  config = function()
    require("leetbuddy").setup({})
  end,
  keys = {
    { "<leader>lq", "<cmd>LBQuestions<cr>", desc = "LeetCode Questions List" },
    { "<leader>ll", "<cmd>LBQuestion<cr>", desc = "View Question" },
    { "<leader>lr", "<cmd>LBReset<cr>", desc = "Reset Code" },
    { "<leader>lt", "<cmd>LBTest<cr>", desc = "Run Tests" },
    { "<leader>ls", "<cmd>LBSubmit<cr>", desc = "Submit Solution" },
  },
}
