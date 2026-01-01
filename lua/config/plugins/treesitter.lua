return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "lua", "json", "jsonc", "css", "rust", "javascript", "typescriptreact", "html", "yaml" },
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
