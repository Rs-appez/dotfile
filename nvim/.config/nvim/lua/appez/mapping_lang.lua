-- run script
local execute_mapping = "<leader>rs"
local function execute_script(cmd)
    if cmd == nil or cmd == "" then
        cmd = "cat"
    end
    return ":w<CR>:sp<CR>:term time " .. cmd .. " %<CR>"
end

-- log
local log_mapping = "<leader>lg"
local log_macro = 'viw"lyoprint(""lpa : ", "lpa)'

-- Python
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.keymap.set("n", execute_mapping, execute_script("python3"))
        vim.keymap.set("n", log_mapping, log_macro)
    end,
})

-- Lua
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
        vim.keymap.set("n", execute_mapping, execute_script("lua"))
        vim.keymap.set("n", log_mapping, log_macro)
    end,
})
