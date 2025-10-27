-- CodeCompanion.nvim - Лучший AI-ассистент для Neovim с поддержкой Claude
-- Работает с Anthropic API (доступен через Cursor подписку)
return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
        {
            "stevearc/dressing.nvim",
            opts = {},
        },
    },
    config = function()
        -- Настройка модели Ollama через переменные окружения
        -- Можно изменить модель здесь:
        vim.g.codecompanion_adapter_ollama_model = "deepseek-coder-v2:16b"  -- Измените модель здесь
        
        require("codecompanion").setup({
            strategies = {
                chat = {
                    adapter = "ollama", -- Используем локальную модель Ollama
                },
                inline = {
                    adapter = "ollama",
                },
                agent = {
                    adapter = "ollama",
                },
            },
            -- Используем встроенные адаптеры без переопределения
            -- Ollama работает из коробки, не нужно настраивать адаптер
            
            -- Для изменения модели используйте одно из:
            -- 1. vim.g.codecompanion_adapter_ollama_model = "model-name" (выше)
            -- 2. export CODECOMPANION_ADAPTER_OLLAMA_MODEL="model-name" в ~/.zshrc
            
            -- Доступные модели:
            -- - deepseek-coder-v2:16b (текущая, лучшая для кода)
            -- - qwen2.5-coder:7b (быстрая и хорошая)
            -- - codellama:13b (CodeLlama)
            -- - llama3.1:8b (универсальная)
            
            display = {
                chat = {
                    window = {
                        layout = "vertical", -- vertical = sidebar справа, как в Cursor
                        border = "rounded",
                        width = 0.3, -- 30% ширины экрана для sidebar
                        relative = "editor",
                        opts = {
                            breakindent = true,
                            cursorcolumn = false,
                            cursorline = false,
                            foldcolumn = "0",
                            linebreak = true,
                            list = false,
                            wrap = true, -- Перенос текста
                        },
                    },
                    intro_message = "👋 Привет! Я AI-ассистент на базе Claude 3.5 Sonnet. Я вижу контекст всего проекта и готов помочь с кодом!",
                },
                inline = {
                    -- Инлайн подсказки как в Cursor
                    diff = {
                        enabled = true,
                        close_chat_at = 240,
                        layout = "vertical",
                        opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
                        separator = "---",
                    },
                },
            },
            opts = {
                log_level = "ERROR",
                send_code = true,
                use_default_actions = true,
                use_default_prompt_library = true,
            },
            -- Промпты на русском
            prompt_library = {
                ["Объяснить код"] = {
                    strategy = "chat",
                    description = "Объяснить выделенный код",
                    opts = {
                        index = 1,
                        is_default = true,
                        is_slash_cmd = false,
                        user_prompt = true,
                    },
                    prompts = {
                        {
                            role = "system",
                            content = [[Ты опытный программист. Объясни выделенный код простым языком на русском. 
Опиши что делает код, как он работает, и почему он написан именно так.
Если есть потенциальные проблемы - укажи на них.]],
                        },
                        {
                            role = "user",
                            content = function(context)
                                return "Объясни этот код:\n\n```" .. context.filetype .. "\n" .. context.selection .. "\n```"
                            end,
                        },
                    },
                },
                ["Код-ревью"] = {
                    strategy = "chat",
                    description = "Провести код-ревью",
                    opts = {
                        index = 2,
                        is_default = true,
                    },
                    prompts = {
                        {
                            role = "system",
                            content = [[Ты senior разработчик. Проведи детальное код-ревью на русском языке.
Проверь:
- Безопасность кода
- Производительность
- Читаемость и поддерживаемость
- Best practices
- Потенциальные баги
- Возможности оптимизации

Дай конкретные рекомендации по улучшению.]],
                        },
                        {
                            role = "user",
                            content = function(context)
                                return "Проведи код-ревью:\n\n```" .. context.filetype .. "\n" .. context.selection .. "\n```"
                            end,
                        },
                    },
                },
                ["Исправить баги"] = {
                    strategy = "chat",
                    description = "Найти и исправить баги",
                    opts = {
                        index = 3,
                        is_default = true,
                    },
                    prompts = {
                        {
                            role = "system",
                            content = [[Найди все баги и проблемы в коде. Предложи исправленную версию.
Объясни на русском языке:
- Какие баги были найдены
- Почему они возникли
- Как ты их исправил
- Что нужно сделать чтобы избежать подобных багов в будущем]],
                        },
                        {
                            role = "user",
                            content = function(context)
                                return "Найди и исправь баги:\n\n```" .. context.filetype .. "\n" .. context.selection .. "\n```"
                            end,
                        },
                    },
                },
                ["Оптимизировать"] = {
                    strategy = "chat",
                    description = "Оптимизировать код",
                    opts = {
                        index = 4,
                        is_default = true,
                    },
                    prompts = {
                        {
                            role = "system",
                            content = [[Оптимизируй код для лучшей производительности и читаемости.
Объясни на русском:
- Какие оптимизации были сделаны
- Почему они улучшают код
- Есть ли trade-offs

Сохрани функциональность и улучши код.]],
                        },
                        {
                            role = "user",
                            content = function(context)
                                return "Оптимизируй этот код:\n\n```" .. context.filetype .. "\n" .. context.selection .. "\n```"
                            end,
                        },
                    },
                },
                ["Добавить документацию"] = {
                    strategy = "inline",
                    description = "Добавить документацию к коду",
                    opts = {
                        index = 5,
                        is_default = true,
                    },
                    prompts = {
                        {
                            role = "system",
                            content = [[Добавь подробную документацию к коду:
- JSDoc для JavaScript/TypeScript
- Docstrings для Python
- Соответствующий формат для других языков

Комментарии пиши на русском языке. Сохрани весь оригинальный код.]],
                        },
                        {
                            role = "user",
                            content = function(context)
                                return "Добавь документацию:\n\n```" .. context.filetype .. "\n" .. context.selection .. "\n```"
                            end,
                        },
                    },
                },
                ["Сгенерировать тесты"] = {
                    strategy = "chat",
                    description = "Создать unit-тесты",
                    opts = {
                        index = 6,
                        is_default = true,
                    },
                    prompts = {
                        {
                            role = "system",
                            content = [[Создай comprehensive unit-тесты для кода.
Используй подходящий testing framework для языка.
Покрой:
- Happy path
- Edge cases
- Error cases
- Граничные условия

Комментарии и описания тестов на русском.]],
                        },
                        {
                            role = "user",
                            content = function(context)
                                return "Создай тесты для:\n\n```" .. context.filetype .. "\n" .. context.selection .. "\n```"
                            end,
                        },
                    },
                },
                ["Рефакторинг"] = {
                    strategy = "chat",
                    description = "Отрефакторить код",
                    opts = {
                        index = 7,
                        is_default = true,
                    },
                    prompts = {
                        {
                            role = "system",
                            content = [[Отрефактори код для улучшения:
- Читаемости
- Поддерживаемости
- Соответствия best practices
- Разделения ответственности

Объясни на русском какие изменения сделал и почему.]],
                        },
                        {
                            role = "user",
                            content = function(context)
                                return "Отрефактори:\n\n```" .. context.filetype .. "\n" .. context.selection .. "\n```"
                            end,
                        },
                    },
                },
                ["Commit message"] = {
                    strategy = "chat",
                    description = "Сгенерировать commit message",
                    opts = {
                        index = 8,
                        is_default = true,
                    },
                    prompts = {
                        {
                            role = "system",
                            content = [[Проанализируй git diff и создай commit message в формате Conventional Commits:
<type>(<scope>): <description>

[optional body]

[optional footer]

Используй английский язык для commit message.]],
                        },
                        {
                            role = "user",
                            content = function()
                                return "Создай commit message для:\n\n" .. vim.fn.system("git diff --staged")
                            end,
                        },
                    },
                },
            },
        })

        -- Основные команды
        vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle AI Chat" })
        vim.keymap.set("v", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle AI Chat" })
        
        -- Добавить выделение в чат
        vim.keymap.set("v", "<leader>ca", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add Selection to Chat" })

        -- Inline chat (как в Cursor)
        vim.keymap.set({ "n", "v" }, "<leader>ci", "<cmd>CodeCompanion<cr>", { desc = "Inline AI Chat" })

        -- Быстрые действия с кодом
        vim.keymap.set("v", "<leader>ce", function()
            require("codecompanion").prompt("Объяснить код")
        end, { desc = "AI Explain Code" })

        vim.keymap.set("v", "<leader>cr", function()
            require("codecompanion").prompt("Код-ревью")
        end, { desc = "AI Code Review" })

        vim.keymap.set("v", "<leader>cf", function()
            require("codecompanion").prompt("Исправить баги")
        end, { desc = "AI Fix Bugs" })

        vim.keymap.set("v", "<leader>co", function()
            require("codecompanion").prompt("Оптимизировать")
        end, { desc = "AI Optimize Code" })

        vim.keymap.set("v", "<leader>cd", function()
            require("codecompanion").prompt("Добавить документацию")
        end, { desc = "AI Add Docs" })

        vim.keymap.set("v", "<leader>ct", function()
            require("codecompanion").prompt("Сгенерировать тесты")
        end, { desc = "AI Generate Tests" })

        vim.keymap.set("v", "<leader>cR", function()
            require("codecompanion").prompt("Рефакторинг")
        end, { desc = "AI Refactor" })

        -- Commit message
        vim.keymap.set("n", "<leader>cm", function()
            require("codecompanion").prompt("Commit message")
        end, { desc = "AI Commit Message" })

        -- Telescope integration для выбора промптов
        vim.keymap.set({ "n", "v" }, "<leader>cp", "<cmd>CodeCompanionActions<cr>", { desc = "AI Prompt Actions" })

        -- Открыть чат с вопросом
        vim.keymap.set("n", "<leader>cq", function()
            vim.ui.input({ prompt = "Ask AI: " }, function(input)
                if input and input ~= "" then
                    require("codecompanion").chat(input)
                end
            end)
        end, { desc = "Quick AI Question" })
    end,
}

