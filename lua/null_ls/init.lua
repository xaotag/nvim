local null_ls = require("null-ls")
local mySource = require('null_ls.source')

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  debug = false,
  sources = mySource,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({bufnr = bufnr})
          --  vim.lsp.buf.formatting_sync()
        end
      })
    end
  end
})
