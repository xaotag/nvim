require("lspkind").init(
  {
    -- enables text annotations
    --
    -- default: true
    with_text = true,
    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = "codicons",
    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
    }
  }
)

local lspkind = require("lspkind")
local cmp = require "cmp"
cmp.setup {
  formatting = {
    format = lspkind.cmp_format(
      {
        with_text = true, -- do not show text alongside icons
        maxwidth = 50,
        before = function(entry, vim_item)
          return vim_item
        end
      }
    )
  }
}

