return {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "mg979/vim-visual-multi", -- nvim debuger
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
  },
  "windwp/nvim-ts-autotag",
  "ellisonleao/glow.nvim",
  {
    "booperlv/nvim-gomove",
    config = function()
      require("gomove").setup({
        map_defaults = false,
        reindent = true,
        undojoin = true,
        move_past_end_col = false,
      })

      local keymap = vim.keymap.set
      keymap("n", "<S-h>", "<Plug>GoNSMLeft", { silent = true, desc = "向左移动代码" })
      keymap("n", "<S-j>", "<Plug>GoNSMDown", { silent = true, desc = "向下移动代码" })
      keymap("n", "<S-k>", "<Plug>GoNSMUp", { silent = true, desc = "向上移动代码" })
      keymap("n", "<S-l>", "<Plug>GoNSMRight", { silent = true, desc = "向右移动代码" })

      keymap("x", "<S-h>", "<Plug>GoVSMLeft", { silent = true, desc = "可视模式向左移动代码" })
      keymap("x", "<S-j>", "<Plug>GoVSMDown", { silent = true, desc = "可视模式向下移动代码" })
      keymap("x", "<S-k>", "<Plug>GoVSMUp", { silent = true, desc = "可视模式向上移动代码" })
      keymap("x", "<S-l>", "<Plug>GoVSMRight", { silent = true, desc = "可视模式向右移动代码" })
    end,
  },
  "b0o/schemastore.nvim",
  "gennaro-tedesco/nvim-commaround",
  "AndrewRadev/tagalong.vim",
  "ray-x/guihua.lua",
}
