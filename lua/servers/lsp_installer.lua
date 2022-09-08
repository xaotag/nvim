local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
local lspconfig = require("lspconfig")

local lsp_installer = require("nvim-lsp-installer")

local servers = {
  "cssls", "cssmodules_ls", "emmet_ls", "html", "jsonls", "sumneko_lua",
  "tsserver", "gopls", "yamlls", "dockerls"
}

lsp_installer.setup(servers)
local opts = {}
local settings = {ensure_installed = servers}
for _, lsp in ipairs(servers) do
  opts = {capabilities = capabilities}
  if lsp == 'jsonls' then
    local jsonls_opts = require "servers.lsp.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  elseif lsp == 'gopls' then
    local gopls_opts = require "servers.lsp.gopls"
    opts = vim.tbl_deep_extend("force", gopls_opts, opts)
  end
  lspconfig[lsp].setup({opts = opts})
end
