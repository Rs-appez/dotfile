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
local function run_module()
    local current_file = vim.fn.expand("%:p")
    local cwd = vim.fn.getcwd()
    local rel_path = current_file:sub(#cwd + 2):gsub("%.py$", ""):gsub("/", ".")
    print("rel_path : ", rel_path)
    if rel_path ~= "" then
        return ":wa<CR>:sp<CR>:term time python3 -m " .. rel_path .. "<CR>"
    end
    return ":echo 'Cannot determine module name'<CR>"
end
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.keymap.set("n", execute_mapping, execute_script("python3"))
        vim.keymap.set("n", log_mapping, log_macro_print)
        vim.keymap.set("n", "<leader>rm", run_module(), { desc = "Run current Python module" })
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
