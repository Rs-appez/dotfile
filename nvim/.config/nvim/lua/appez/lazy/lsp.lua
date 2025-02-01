return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },

    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig.health").check()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "angularls",
                "bashls",
                "html",
                "ts_ls",
                "pyright",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
            },
        })
    end,
}
