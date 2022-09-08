local saga = require('lspsaga')
saga.init_lsp_saga({diagnostic_header = {" ", " ", " ", "ﴞ "}})

local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Information = "ﴞ "
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end
