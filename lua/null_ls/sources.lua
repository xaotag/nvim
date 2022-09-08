local M = {}
local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
-- LuaFormatter off
M.sources = {
  formatting.prettier.with({
    filetypes = { "html", "yaml", "yml", "markdown", "css", "scss", "less" },
  }),
  formatting.google_java_format.with({
    filetypes = { "java" },
  }),
  formatting.deno_fmt.with({
    extra_args = { "--options-single-quote" }
  }),
  formatting.lua_format.with({
    args = { "--indent-width", "2" }
  }),
  formatting.gofmt.with({
    filetypes = { "go" },
  }),
  diagnostics.eslint
}

-- LuaFormatter on
return M
