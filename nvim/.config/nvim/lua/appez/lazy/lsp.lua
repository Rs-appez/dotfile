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
            ensure_installed = {},
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
        require("lspconfig").omnisharp.setup({
            cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/OmniSharp") },
            filetypes = { "cs" },
            root_dir = function()
                return vim.loop.cwd()
            end,
            enable_import_completion = true,
            organize_imports_on_format = true,
            enable_roslyn_analyzers = true,
        })
    end,
}
