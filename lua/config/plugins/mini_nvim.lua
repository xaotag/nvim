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
        animation = require("mini.indentscope").gen_animation.none(), -- 追求零延迟的瞬发感
      },
      options = {
        border = "top", -- 关键：让线条从函数定义的开头“折”出来
      },
    },
    config = function(_, opts)
      require("mini.indentscope").setup(opts)
      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#565f89", blend = 20 })
    end,
  },
}
