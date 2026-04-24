return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- 基础配置
    require("nvim-treesitter").setup({})

    -- 安装解析器
    require("nvim-treesitter").install({
      "rust",
      "lua",
      "vim",
      "toml",
      "bash",
      "c",
      "cpp",
      "go",
      "python",
      "javascript",
      "typescript",
      "tsx",
      "html",
      "css",
      "json",
      "yaml",
      "markdown",
      "markdown_inline",
      "regex",
    })

    -- Treesitter 高亮 (Neovim 内置)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "lua",
        "vim",
        "rust",
        "go",
        "python",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "json",
        "yaml",
        "markdown",
        "toml",
        "bash",
        "c",
        "cpp",
      },
      callback = function(args)
        vim.treesitter.start(args.buf)
      end,
    })

    -- Treesitter 折叠 (Neovim 内置)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "lua",
        "vim",
        "rust",
        "go",
        "python",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "json",
        "yaml",
        "markdown",
        "toml",
        "bash",
        "c",
        "cpp",
      },
      callback = function()
        vim.wo[0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0].foldmethod = "expr"
        vim.wo[0].foldlevel = 99
      end,
    })

    -- Treesitter 缩进 (实验性)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "lua",
        "vim",
        "rust",
        "go",
        "python",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "json",
        "yaml",
        "toml",
        "bash",
        "c",
        "cpp",
      },
      callback = function(args)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    -- 彩虹括号颜色
    vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#e67e80" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#dbbc7f" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#7fbbb3" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#e69875" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#a7c080" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#d699b6" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#83c092" })

    -- 重复移动功能
    local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

    -- 移动跳转
    local ts_move = require("nvim-treesitter-textobjects.move")
    for _, item in ipairs({
      { next = "]f", prev = "[f", query = "@function.outer", name = "function" },
      { next = "]c", prev = "[c", query = "@class.outer", name = "class" },
      { next = "]b", prev = "[b", query = "@block.outer", name = "block" },
      { next = "]l", prev = "[l", query = "@loop.outer", name = "loop" },
      { next = "]i", prev = "[i", query = "@conditional.outer", name = "conditional" },
    }) do
      vim.keymap.set({ "n", "x", "o" }, item.next, function()
        ts_move.goto_next_start(item.query, "textobjects")
      end, { desc = "Goto next " .. item.name })
      vim.keymap.set({ "n", "x", "o" }, item.prev, function()
        ts_move.goto_previous_start(item.query, "textobjects")
      end, { desc = "Goto previous " .. item.name })
    end

    -- textobjects 选择
    --  local ts_select = require("nvim-treesitter-textobjects.select")
    --  for _, obj in ipairs({
    --    { key = "af", query = "@function.outer" },
    --    { key = "if", query = "@function.inner" },
    --    { key = "ac", query = "@class.outer" },
    --    { key = "ic", query = "@class.inner" },
    --    { key = "ab", query = "@block.outer" },
    --    { key = "ib", query = "@block.inner" },
    --    { key = "al", query = "@loop.outer" },
    --    { key = "il", query = "@loop.inner" },
    --    { key = "ai", query = "@conditional.outer" },
    --    { key = "ii", query = "@conditional.inner" },
    --    { key = "ap", query = "@parameter.outer" },
    --    { key = "ip", query = "@parameter.inner" },
    --  }) do
    --    vim.keymap.set({ "x", "o" }, obj.key, function()
    --      ts_select.select_textobject(obj.query, "textobjects")
    --    end, { desc = "Select " .. obj.query })
    --  end
  end,
}
