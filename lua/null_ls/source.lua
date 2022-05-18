local M = {}
local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local hover = null_ls.builtins.hover

-- LuaFormatter off
M.sources = {
--	formatting.prettier.with({
--		filetypes = { "html", "json", "yaml", "javascript","javascriptreact","typescript","typescriptreact" }
--	}),
	formatting.deno_fmt,
	formatting.lua_format.with({
		extra_args={"--indent-width","2"}
	}),
	diagnostics.eslint
}

-- LuaFormatter on
return M
