vim.g.copilot_enabled = true
vim.keymap.set('i', '<C-J>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-line)')

return {
    { "github/copilot.vim" },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },                       -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken",                            -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
            -- lazy.nvim opts

            window = {
                layout = "horizontal",
            },
            mappings = {
                complete = false, -- disable default mapping
            },
        },
        -- See Commands section for default commands if you want to lazy load on them

        keys = {
            -- Quick chat with Copilot
            {
                "<leader>ccq",
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then
                        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
                    end
                end,
                desc = "CopilotChat - Quick chat",
            },

            -- Show prompts actions with telescope
            {
                "<leader>ccp",
                function()
                    require("CopilotChat").select_prompt()
                end,
                desc = "CopilotChat - Prompt actions",
            },
            -- Open CopilotChat
            {
                "<leader>cco",
                function()
                    require("CopilotChat").open()
                end,
                desc = "Open CopilotChat",
            },
            -- Select model
            {
                "<leader>ccm",
                function()
                    require("CopilotChat").select_model()
                end,
                desc = "CopilotChat - Select model",
            },
            -- Toggle Copilot AutoComplete
            {
                "<leader>cct",
                function()
                    vim.g.copilot_enabled = not vim.g.copilot_enabled
                    vim.notify("Copilot AutoComplete: " .. (vim.g.copilot_enabled and "Enabled" or "Disabled"))
                end,
                desc = "Toggle Copilot AutoComplete",

            }
        }
    },
}
