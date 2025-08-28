return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lf = require("appez.lualine_functions")
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
                        lf.copilotModel,
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
                lualine_y = {
                    {
                        lf.selectionCount,
                        cond = function()
                            return vim.fn.mode():find("[vV]") ~= nil
                        end,
                        color = { fg = "#a3be8c" },
                    },
                    "encoding", "fileformat", "filetype" },
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
