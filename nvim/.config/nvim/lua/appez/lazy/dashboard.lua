return {
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        config = function()
            require("dashboard").setup({
                theme = "hyper",
                config = {
                    week_header = {
                        enable = true,
                    },
                    shortcut = {},
                },
            })
        end,
        dependencies = { { "nvim-tree/nvim-web-devicons" } },
    },
}
