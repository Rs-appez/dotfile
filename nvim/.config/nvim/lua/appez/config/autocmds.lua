-- LSP autocmds
local on_attach = require("appez.utils.lsp").on_attach
local lsp_on_attach_group = vim.api.nvim_create_augroup("LspMappings", {})
vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_on_attach_group,
    callback = on_attach,
})
-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
