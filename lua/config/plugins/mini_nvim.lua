return {
  {
    "nvim-mini/mini.pairs",
    version = "*",
    config = function()
      require("mini.pairs").setup({})
    end,
  },
  {
    "echasnovski/mini.indentscope",
    opts = {
      symbol = "╎", -- 使用这种虚线，在 Kitty 里会有极高级的科技感
      draw = {
        delay = 0,
      },
    },
    config = function(_, opts)
      require("mini.indentscope").setup(opts)
      -- 进化的色彩：让这条线带有一点点渐变或褪色感
      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#565f89", blend = 20 })
    end,
  },
}
