return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        enabled = false,
        dependencies = { "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = { "node_modules", ".git" },
                },
                extensions = {
                    fzf = {},
                },
            })
            require("telescope").load_extension("fzf")

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
            vim.keymap.set("n", "<leader>en", function()
                    builtin.find_files { cwd = vim.fn.stdpath("config") }
                end,
                { desc = "Telescope find nvim config" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
            vim.keymap.set("n", "<C-p>", builtin.git_files, {})
            vim.keymap.set("n", "<leader>ps", function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end)
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            -- This is your opts table
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
