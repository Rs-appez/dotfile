return {
    "neovim/nvim-lspconfig",
    dependencies = {

        { "williamboman/mason.nvim",           version = "^1.0.0" },
        { "williamboman/mason-lspconfig.nvim", version = "^1.0.0" },
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
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
            },
        })
        require("lspconfig").djlsp.setup({
            cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/djlsp") },
            filetypes = { "htmldjango" },
            init_options = {
                django_settings_module = "",
                docker_compose_file = "docker-compose.yml",
                docker_compose_service = "django",
            },
        })
    end,
}
