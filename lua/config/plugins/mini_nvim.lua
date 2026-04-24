return {
  {
    "nvim-mini/mini.pairs",
    version = "*",
    config = function()
      require("mini.pairs").setup({})
    end,
  },
  {
    "nvim-mini/mini.ai",
    version = "*",
    config = function()
      local ai = require("mini.ai")
      ai.setup({
        n_lines = 500, -- 搜索范围加大一点，方便处理大函数
        custom_textobjects = {
          -- 核心：把 Treesitter 的语义能力塞进 mini.ai
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
          b = ai.gen_spec.treesitter({ a = "@block.outer", i = "@block.inner" }),
          l = ai.gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
          i = ai.gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }),
          p = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),

          -- 你甚至可以加一些 Treesitter 做不到的，比如基于正则的对象
          -- 比如选中的是一个 Rust 的变量定义或者类似的东西
        },
        mappings = {
          -- 保持默认：a = around, i = inside
          -- 自动获得了：anf (下一个函数), alf (上一个函数), ina (下一个参数)
        },
      })
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
