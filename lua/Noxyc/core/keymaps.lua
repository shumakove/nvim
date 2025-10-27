local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visaual selection" })
vim.keymap.set("v", "K", ":m '< -2<CR>gv=gv", { desc = "moves lines up in visaual selection" })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "C-d>zz", { desc = "move down if buffer with cursor entered"})
vim.keymap.set("n", "<C-u>", "C-u>zz", { desc = "move up if buffer with cursor entered"})

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Paste without replacing clipboard content
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("v", "p", '"_dp', opts)

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search hl", silent = true})

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "x", '"_x', opts) -- prevents deleted characters from copying to clipboard

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "make file executable" })

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
-- tab stuff
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>")
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>")
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>")
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>")
vim.keymap.set("n", "<leader>tf", "<cmd>tabf<CR>")
--split
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w> =", { desc = "Make split equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function() 
    local filePath = vim.fn.expand("%:~")
    vim.fn.setreg("+", filePath)
    print("File path copied to clipboard " .. filePath)
end, { desc = "Copy file path to clipboard" })

-- Open AI Guide
vim.keymap.set("n", "<leader>?", function()
    local guide_path = vim.fn.stdpath("config") .. "/CURSOR_AI_GUIDE.md"
    vim.cmd("edit " .. guide_path)
end, { desc = "Open AI Guide for Cursor/Claude" })

-- Quick open AI quickstart
vim.keymap.set("n", "<leader>??", function()
    local guide_path = vim.fn.stdpath("config") .. "/QUICKSTART_CURSOR.md"
    vim.cmd("edit " .. guide_path)
end, { desc = "Open AI Quickstart" })

-- Open Layout settings
vim.keymap.set("n", "<leader>?l", function()
    local guide_path = vim.fn.stdpath("config") .. "/LAYOUT_SETTINGS.md"
    vim.cmd("edit " .. guide_path)
end, { desc = "Open AI Layout Settings" })

-- Open Ollama guide
vim.keymap.set("n", "<leader>?o", function()
    local guide_path = vim.fn.stdpath("config") .. "/OLLAMA_GUIDE.md"
    vim.cmd("edit " .. guide_path)
end, { desc = "Open Ollama Guide (Local AI)" })

-- Open File Explorer guide
vim.keymap.set("n", "<leader>?e", function()
    local guide_path = vim.fn.stdpath("config") .. "/FILE_EXPLORER_GUIDE.md"
    vim.cmd("edit " .. guide_path)
end, { desc = "Open File Explorer Guide" })

-- Open Switch to Claude guide
vim.keymap.set("n", "<leader>?c", function()
    local guide_path = vim.fn.stdpath("config") .. "/SWITCH_TO_CLAUDE.md"
    vim.cmd("edit " .. guide_path)
end, { desc = "How to Switch to Claude API" })
