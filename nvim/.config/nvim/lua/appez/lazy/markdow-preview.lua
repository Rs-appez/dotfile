-- install without yarn or npm
return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = { "markdown" },
	keys = {
		{
			"<leader>mk",
			function()
				vim.cmd("MarkdownPreviewToggle")
			end,
			desc = "Markdown Preview Start/Stop",
		},
	},
}
