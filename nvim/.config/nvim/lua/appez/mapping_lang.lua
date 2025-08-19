-- run script
local execute_mapping = "<leader>rs"
local function execute_script(cmd, include_filename)
    cmd = cmd or "cat"
    include_filename = include_filename or true
    local filename = ""
    if include_filename then
        filename = " %"
    end
    return ":wa<CR>:sp<CR>:term time " .. cmd .. filename .. "<CR>"
end

-- log
local log_mapping = "<leader>lg"
local log_macro_print = 'viw"lyoprint(""lpa : ", "lpa)'

-- Python
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.keymap.set("n", execute_mapping, execute_script("python3"))
        vim.keymap.set("n", log_mapping, log_macro_print)
    end,
})

-- Lua
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
        vim.keymap.set("n", execute_mapping, execute_script("lua"))
        vim.keymap.set("n", log_mapping, log_macro_print)
    end,
})

-- C#
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cs",
    callback = function()
        vim.keymap.set("n", execute_mapping, execute_script("dotnet run", false))
        vim.keymap.set("n", log_mapping, 'viw"lyoConsole.WriteLine(""lpa : " + "lpa);'
        )
    end,
})

-- Rust
vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        vim.keymap.set("n", execute_mapping, execute_script("cargo run", false))
        vim.keymap.set("n", log_mapping, 'viw"lyoprintln!(""lpa : {}", "lpa);')
    end,
})

-- Go
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.keymap.set("n", execute_mapping, execute_script("go run"))
        vim.keymap.set("n", log_mapping, 'viw"lyoprintln(""lpa : ", "lpa)')
    end,
})
