return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "mason-org/mason.nvim",          opts = {} },
        { "mason-org/mason-lspconfig.nvim" },
    },
    config = function()
        require("appez.utils.diagnostics").setup()

        -- Auto-discover and enable all lsp/*.lua configs
        local lsp_dir = vim.fn.stdpath("config") .. "/after/lsp"
        local servers = {}
        for _, file in ipairs(vim.fn.glob(lsp_dir .. "/*.lua", false, true)) do
            table.insert(servers, vim.fn.fnamemodify(file, ":t:r"))
        end

        -- Install discovered servers via mason
        require("mason-lspconfig").setup({
            ensure_installed = servers,
            automatic_installation = true,
        })

        vim.lsp.enable(servers)
    end,

}
