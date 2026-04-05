local autocmd = vim.api.nvim_create_autocmd

local augroup = vim.api.nvim_create_augroup
local AppezGroup = augroup("AppezGroup", {})

autocmd("LspAttach", {
	group = AppezGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set({"n","v"}, "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
	end,
})
