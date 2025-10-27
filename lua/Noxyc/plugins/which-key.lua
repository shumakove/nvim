-- Which-key для отображения подсказок клавиш
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "modern",
        delay = 300,
        plugins = {
            marks = true,
            registers = true,
            spelling = {
                enabled = true,
                suggestions = 20,
            },
        },
        win = {
            border = "rounded",
            padding = { 1, 2 },
        },
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)

        -- Регистрация групп для AI функций
        wk.add({
            { "<leader>c", group = "🤖 AI Claude" },
            { "<leader>cc", desc = "Toggle Chat" },
            { "<leader>ca", desc = "Add to Chat (visual)", mode = "v" },
            { "<leader>ci", desc = "Inline Chat" },
            { "<leader>cq", desc = "Quick Question" },
            { "<leader>ce", desc = "Explain Code", mode = "v" },
            { "<leader>cr", desc = "Code Review", mode = "v" },
            { "<leader>cR", desc = "Refactor", mode = "v" },
            { "<leader>cf", desc = "Fix Bugs", mode = "v" },
            { "<leader>co", desc = "Optimize", mode = "v" },
            { "<leader>cd", desc = "Add Docs", mode = "v" },
            { "<leader>ct", desc = "Generate Tests", mode = "v" },
            { "<leader>cm", desc = "Commit Message" },
            { "<leader>cp", desc = "Prompt Actions" },

            { "<leader>a", group = "🎯 Avante (если включен)" },
            { "<leader>aa", desc = "Ask AI" },
            { "<leader>ae", desc = "Edit with AI" },
            { "<leader>ar", desc = "Refresh" },

            { "<leader>p", group = "🔍 Project/Search" },
            { "<leader>pr", desc = "Recent Files" },
            { "<leader>pW", group = "Word Search" },

            { "<leader>v", group = "📝 LSP" },
            { "<leader>vca", desc = "Code Action" },

            { "<leader>t", group = "📑 Tabs" },
            { "<leader>to", desc = "New Tab" },
            { "<leader>tx", desc = "Close Tab" },
            { "<leader>tn", desc = "Next Tab" },
            { "<leader>tp", desc = "Previous Tab" },
            { "<leader>tf", desc = "Find Tab" },
            { "<leader>th", group = "🎨 Themes" },

            { "<leader>s", group = "🪟 Splits/Search" },
            { "<leader>sv", desc = "Split Vertical" },
            { "<leader>sh", desc = "Split Horizontal" },
            { "<leader>se", desc = "Equal Size" },
            { "<leader>sx", desc = "Close Split" },

            { "<leader>f", group = "📁 File" },
            { "<leader>fp", desc = "Copy File Path" },
            
            { "<leader>e", desc = "Toggle File Explorer" },
            { "<leader>E", desc = "Reveal Current File in Explorer" },

            { "<leader>g", group = "🔀 Git" },
            { "<leader>gg", desc = "LazyGit" },
            { "<leader>gf", desc = "LazyGit Current File" },
            { "<leader>gd", desc = "DiffView Open" },
            { "<leader>gh", desc = "File History" },
            { "<leader>gH", desc = "Branch History" },
            { "<leader>gc", desc = "DiffView Close" },
            
            { "<leader>h", group = "Git Hunks" },
            { "<leader>hs", desc = "Stage hunk" },
            { "<leader>hr", desc = "Reset hunk" },
            { "<leader>hS", desc = "Stage buffer" },
            { "<leader>hR", desc = "Reset buffer" },
            { "<leader>hp", desc = "Preview hunk" },
            { "<leader>hb", desc = "Blame line" },
            { "<leader>hB", desc = "Toggle line blame" },
            { "<leader>hd", desc = "Diff this" },
            { "<leader>hu", desc = "Undo stage hunk" },
            
            { "]h", desc = "Next Git hunk" },
            { "[h", desc = "Previous Git hunk" },

            { "g", group = "📍 Go to" },
            { "gR", desc = "LSP References" },
            { "gD", desc = "Declaration" },
            { "gd", desc = "Definition" },
            { "gi", desc = "Implementation" },
            { "gt", desc = "Type Definition" },

            { "K", desc = "Hover Documentation" },

            { "<leader>r", group = "🔄 Refactor" },
            { "<leader>rn", desc = "Rename Symbol" },
            { "<leader>rs", desc = "Restart LSP" },

            { "<leader>D", desc = "Buffer Diagnostics" },
            { "<leader>d", desc = "Line Diagnostics" },

            { "<leader>?", group = "📚 Help" },
            { "<leader>?", desc = "Open AI Guide" },
            { "<leader>??", desc = "Open AI Quickstart" },
            { "<leader>?l", desc = "Open Layout Settings" },
            { "<leader>?o", desc = "Open Ollama Guide (Local AI)" },
            { "<leader>?e", desc = "Open File Explorer Guide" },
            { "<leader>?g", desc = "Open Git Guide" },
        })
    end,
}

