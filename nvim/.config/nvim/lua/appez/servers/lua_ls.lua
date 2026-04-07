-- ================================================================================================
-- TITLE : lua_ls (Lua Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/LuaLS/lua-language-server
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
    vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = {
                        "vim",
                        "require",
                    },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                },
            }
        }
    })
end
