return {
	"neovim/nvim-lspconfig",
	dependencies = {

		{ "williamboman/mason.nvim", version = "^1.0.0" },
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
				-- ["basepyright"] = function()
				-- 	require("lspconfig").basepyright.setup({
				--
				-- 		settings = {
				-- 			basepyright = {
				-- 				analysis = {
				-- 					inlayHints = {
				-- 						callArgumentNames = false,
				-- 						functionReturnTypes = false,
				-- 						variableTypes = false,
				-- 					},
				-- 				},
				-- 			},
				-- 		},
				-- 	})
				-- end,
			},
		})
	end,
}
