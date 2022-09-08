local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_config = require("lspconfig")
require("mason").setup()
require("mason-lspconfig").setup()
local mason_lspconfig = require("mason-lspconfig")

local servers = {
  "cssls", "html", "cssmodules_ls", "lua_ls", "tsserver", "gopls", "yamlls",
  "jdtls", "pyright", "jsonls"
}
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local opts = {}
for _, server in pairs(servers) do
  opts = {capabilities = capabilities}
  if server == "jsonls" then
    local jsonls = require "servers.lsp.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls, opts)
  elseif server == "cssls" then
    local cssls = require "servers.lsp.cssls"
    opts = vim.tbl_deep_extend("force", cssls, opts)
  elseif server == "yamlls" then
    local yamlls = require "servers.lsp.yamlls"
    opts = vim.tbl_deep_extend("force", yamlls, opts)
  elseif server == "tsserver" then
    local tsserver = require "servers.lsp.tsserver"
    opts = vim.tbl_deep_extend("force", tsserver, opts)
  elseif server == "gopls" then
    local gopls = require "servers.lsp.gopls"
    opts = vim.tbl_deep_extend("force", gopls, opts)
  end
  require('lspconfig')[server].setup(opts)
end
require('servers.lsp.ls_emmet')
