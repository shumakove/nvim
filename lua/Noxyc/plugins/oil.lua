return {
    "stevearc/oil.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        require("oil").setup({
            default_file_explorer = false, -- start up nvim with oil
            columns = {
                "icon",
            },
            keymaps = {
                ["<C-h>"] = false,
                ["<C-c>"] = false, -- prevent ctrl c from closing out of oil
                ["<M-h>"] = "actions.select_split",
                ["q"] = "actions.close",
            },
            delete_to_trash = true,
            view_options = {
                show_hidden = true,
            },
            skip_confirm_for_simple_edits = true,
        })

        -- keymap for oil
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        vim.keymap.set("n", "<leader> -", require("oil").toggle_float, { desc = "toggle float oil" })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "oil",
            callback = function()
                vim.opt_local.cursorline = true
            end,
        })
    end
}
