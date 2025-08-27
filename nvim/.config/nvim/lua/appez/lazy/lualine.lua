return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                section_separators = { left = "", right = "" },
                component_separators = {},
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff" },
                lualine_c = { "filename" },

                lualine_x = {
                    {
                        function()
                            local ok, cfg = pcall(require, "CopilotChat.config")
                            if not ok or not cfg then return "" end
                            local m = (cfg.options and cfg.options.model) or cfg.model or "?"
                            return "󰚩  " .. m
                        end,
                        cond = function()
                            return package.loaded["CopilotChat.config"] ~= nil
                                and vim.bo.filetype == "copilot-chat"
                        end,
                        color = { fg = "#9063CD" },
                    },
                    {
                        require("noice").api.statusline.mode.get,
                        cond = function()
                            return vim.fn.reg_recording() ~= ""
                        end,
                        color = { fg = "#ff9e64" },
                    },
                },
                lualine_y = { "encoding", "fileformat", "filetype" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = { "nvim-tree" },
        })
    end,
}
