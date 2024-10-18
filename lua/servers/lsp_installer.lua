local lsp_config = require("lspconfig")
require("mason").setup()
require("mason-lspconfig").setup()
local mason_lspconfig = require("mason-lspconfig")

local servers = {
	"cssls",
	"html",
	"cssmodules_ls",
	"lua_ls",
	"ts_ls",
	"gopls",
	"yamlls",
	"jdtls",
	"pyright",
	"jsonls",
	"rust_analyzer",
}
local opts = {}
local capabilities = require("cmp_nvim_lsp").default_capabilities()
for _, server in pairs(servers) do
	opts = {
		capabilities = capabilities,
	}
	if server == "jsonls" then
		local jsonls = require("servers.lsp.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls, opts)
	elseif server == "cssls" then
		local cssls = require("servers.lsp.cssls")
		opts = vim.tbl_deep_extend("force", cssls, opts)
	elseif server == "yamlls" then
		local yamlls = require("servers.lsp.yamlls")
		opts = vim.tbl_deep_extend("force", yamlls, opts)
	elseif server == "ts_ls" then
		local ts_ls = require("servers.lsp.ts_ls")
		opts = vim.tbl_deep_extend("force", ts_ls, opts)
	elseif server == "gopls" then
		local gopls = require("servers.lsp.gopls")
		opts = vim.tbl_deep_extend("force", gopls, opts)
	end
	require("lspconfig")[server].setup(opts)
end
require("servers.lsp.ls_emmet")
