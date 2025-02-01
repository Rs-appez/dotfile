return {
    -- cmp-nvim-lsp
    {
        "hrsh7th/cmp-nvim-lsp",
    },
    -- luasnip
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },
    -- nvim-cmp
    {
        "hrsh7th/nvim-cmp",

        config = function()
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()

            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-f>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<C-Space>"] = cmp.mapping.confirm({ select = true }),
                    -- ["<C-Space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" }, -- For luasnip users.
                }, {
                    { name = "buffer" },
                }),
            })
        end,
    },
}
