return {
	"nvimtools/none-ls.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local formatting = require("null-ls").builtins.formatting
		require("null-ls").setup({
			sources = {
				formatting.prettier.with({
					filetypes = { "html", "yaml", "yml", "markdown" },
				}),
				formatting.google_java_format.with({
					filetypes = { "java" },
				}),
				formatting.stylua,
				formatting.biome,
				formatting.gofmt.with({
					filetypes = { "go" },
				}),
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})
	end,
}
