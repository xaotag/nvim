local saga = require('lspsaga')
saga.setup({
  symbol_in_winbar = {enable = false},
  ui = {border = 'single', colors = {normal_bg = 'NONE'}, title = false}
})

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
