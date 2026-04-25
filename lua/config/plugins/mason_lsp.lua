return {
  "mason-org/mason.nvim",
  config = function()
    require("mason").setup({
      ensure_installed = {
        "json-lsp",
        "vtsls",
        "html-lsp",
        "emmet-ls",
        "gopls",
        "pyright",
        "clangd",
      },
    })
  end,
}
