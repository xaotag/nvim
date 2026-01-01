return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
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
      },
      auto_install = true, -- 自动安装缺失的解析器
      highlight = {
        enable = true, -- 开启高亮
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true }, -- 智能缩进
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>", -- 回车开启选中
          node_incremental = "<CR>", -- 增加选中范围
          node_decremental = "<BS>", -- 减少选中范围
        },
      },
      -- 自动闭合标签
      autotag = {
        enable = true,
        filetypes = { "html", "xml", "tsx", "jsx", "vue", "svelte" },
      },
      -- 文本对象增强
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
        },
        move = {
          enable = true,
          set_jumps = true,
        },
        swap = {
          enable = true,
        },
      },
    })

    -- 禁用顶部上下文预览，改用状态栏导航
    require("treesitter-context").setup({
      enable = false,
    })

    -- 彩虹括号颜色
    vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#e67e80" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#dbbc7f" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#7fbbb3" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#e69875" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#a7c080" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#d699b6" })
    vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#83c092" })

    -- 重复移动功能（类似 ; 和 ,）
    local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

    -- 使用 move 模块的跳转函数
    local ts_move = require("nvim-treesitter-textobjects.move")
    local move_maps = {
      { next = "]f", prev = "[f", query = "@function.outer", name = "function" },
      { next = "]c", prev = "[c", query = "@class.outer", name = "class" },
      { next = "]b", prev = "[b", query = "@block.outer", name = "block" },
      { next = "]l", prev = "[l", query = "@loop.outer", name = "loop" },
      { next = "]i", prev = "[i", query = "@conditional.outer", name = "conditional" },
    }

    for _, item in ipairs(move_maps) do
      vim.keymap.set({ "n", "x", "o" }, item.next, function()
        ts_move.goto_next_start(item.query, "textobjects")
      end, { desc = "Goto next " .. item.name })

      vim.keymap.set({ "n", "x", "o" }, item.prev, function()
        ts_move.goto_previous_start(item.query, "textobjects")
      end, { desc = "Goto previous " .. item.name })
    end

    -- 手动配置 textobjects 选择快捷键
    local ts_select = require("nvim-treesitter-textobjects.select")
    local textobjects_list = {
      { key = "af", query = "@function.outer" },
      { key = "if", query = "@function.inner" },
      { key = "ac", query = "@class.outer" },
      { key = "ic", query = "@class.inner" },
      { key = "ab", query = "@block.outer" },
      { key = "ib", query = "@block.inner" },
      { key = "al", query = "@loop.outer" },
      { key = "il", query = "@loop.inner" },
      { key = "ai", query = "@conditional.outer" },
      { key = "ii", query = "@conditional.inner" },
      { key = "ap", query = "@parameter.outer" },
      { key = "ip", query = "@parameter.inner" },
    }

    for _, obj in ipairs(textobjects_list) do
      vim.keymap.set({ "x", "o" }, obj.key, function()
        ts_select.select_textobject(obj.query, "textobjects")
      end, { desc = "Select " .. obj.query })
    end
  end,
}
