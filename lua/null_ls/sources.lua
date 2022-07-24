local M = {}
local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
-- LuaFormatter off
M.sources = {
	formatting.prettier.with({
		filetypes = { "html", "json", "yaml", "markdown", "css", "scss", "less" },
	}),
	formatting.deno_fmt.with({
		extra_args = { "--options-use-tabs" }
	}),
	formatting.lua_format.with({
		extra_args = { "--indent-width", "2" }
	}),
	formatting.gofmt.with({
		filetypes = { "go" },
	}),
	diagnostics.eslint
}

-- LuaFormatter on
return M
