local M = {}
local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
M.sources = {
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
}
return M
