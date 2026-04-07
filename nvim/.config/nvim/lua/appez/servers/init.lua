local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("appez.servers.lua_ls")(capabilities)
require("appez.servers.docker_ls")(capabilities)

-- Linters & Formatters
require("appez.servers.efm-langserver")(capabilities)

vim.lsp.enable({
    'lua_ls',
    'docker-language-server',
    -- 'pyright',
    -- 'gopls',
    -- 'jsonls',
    -- 'ts_ls',
    -- 'bashls',
    -- 'clangd',
    -- 'emmet_ls',
    -- 'yamlls',
    -- 'tailwindcss',
    -- 'solidity_ls_nomicfoundation',
    -- 'efm',
})
