return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local lualine = require("lualine")
    local colors = {
      bg = "NONE",
      fg = "#bbc2cf",
      -- 结构类型配色
      class = "#ECBE7B", -- 黄色
      struct = "#E5C07B", -- 浅黄
      enum = "#D19A66", -- 橙色
      impl = "#C678DD", -- 紫色
      trait = "#5C6370", -- 深灰
      mod = "#61AFEF", -- 蓝色
      namespace = "#56B6C2", -- 青色

      -- 函数类型配色
      fn_normal = "#98C379", -- 绿色
      fn_method = "#88C0D0", -- 浅蓝
      fn_arrow = "#8FBCBB", -- 青蓝
      fn_literal = "#81A1C1", -- 灰蓝

      -- 控制流配色
      if_stmt = "#E06C75", -- 红色
      for_stmt = "#D19A66", -- 橙色
      while_stmt = "#E5C07B", -- 黄色
      loop_stmt = "#98C379", -- 绿色
      match_stmt = "#56B6C2", -- 青色
      switch_stmt = "#61AFEF", -- 蓝色
      case_stmt = "#C678DD", -- 紫色
      else_stmt = "#BE5046", -- 深红

      -- 变量类型配色
      let_var = "#ABB2BF", -- 浅灰
      const_var = "#E06C75", -- 红色
      param_var = "#98C379", -- 绿色
      var_decl = "#61AFEF", -- 蓝色
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    local sections = {}
    -- Config
    local config = {
      options = {
        -- Disable sections and component separators
        component_separators = "",
        section_separators = "",
        theme = {
          -- We are going to use lualine_c an lualine_x as left and
          -- right section. Both are highlighted by c theme .  So we
          -- are just setting default looks o statusline
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    -- Winbar 插入函数
    local function ins_winbar(component)
      if not config.winbar then
        config.winbar = { lualine_c = {} }
      end
      table.insert(config.winbar.lualine_c, component)
    end

    -- 代码导航栏：Class → Function → Variable
    local function get_code_context()
      local node = vim.treesitter.get_node()
      local bufnr = vim.api.nvim_get_current_buf()
      local context = {}

      -- 支持的节点类型，按嵌套优先级排序，每个类型单独配色
      local node_types = {
        -- 顶层结构
        class_declaration = { icon = "", color = colors.class, priority = 10 },
        struct = { icon = "", color = colors.struct, priority = 10 },
        enum = { icon = "", color = colors.enum, priority = 10 },
        impl_item = { icon = "", color = colors.impl, priority = 10 },
        trait_item = { icon = "", color = colors.trait, priority = 10 },
        mod_item = { icon = "", color = colors.mod, priority = 10 },
        namespace = { icon = "", color = colors.namespace, priority = 10 },

        -- 函数/方法
        function_item = { icon = "󰊕", color = colors.fn_normal, priority = 20 },
        fn_declaration = { icon = "󰊕", color = colors.fn_normal, priority = 20 },
        method_declaration = { icon = "󰊕", color = colors.fn_method, priority = 20 },
        ["function"] = { icon = "󰊕", color = colors.fn_normal, priority = 20 },
        arrow_function = { icon = "󰊕", color = colors.fn_arrow, priority = 20 },
        func_literal = { icon = "󰊕", color = colors.fn_literal, priority = 20 },

        -- 代码块/控制流
        if_statement = { icon = "", color = colors.if_stmt, priority = 30 },
        if_expression = { icon = "", color = colors.if_stmt, priority = 30 },
        else_clause = { icon = "", color = colors.else_stmt, priority = 30 },
        for_statement = { icon = "󰑖", color = colors.for_stmt, priority = 30 },
        while_statement = { icon = "󰑖", color = colors.while_stmt, priority = 30 },
        loop_expression = { icon = "󰑖", color = colors.loop_stmt, priority = 30 },
        match_expression = { icon = "", color = colors.match_stmt, priority = 30 },
        switch_statement = { icon = "", color = colors.switch_stmt, priority = 30 },
        case_clause = { icon = "", color = colors.case_stmt, priority = 30 },

        -- 变量/参数
        let_declaration = { icon = "", color = colors.let_var, priority = 40 },
        const_declaration = { icon = "", color = colors.const_var, priority = 40 },
        parameter = { icon = "", color = colors.param_var, priority = 40 },
        variable_declarator = { icon = "", color = colors.var_decl, priority = 40 },
      }

      -- 向上遍历语法树收集上下文
      while node do
        local node_type = node:type()
        if node_types[node_type] then
          local name = ""

          -- 尝试不同方式提取节点名称
          local name_node = node:field("name")[1]
          if name_node then
            name = vim.treesitter.get_node_text(name_node, bufnr) or ""
          else
            -- 回退到正则匹配
            local text = vim.treesitter.get_node_text(node, bufnr) or ""
            name = text:match("^%s*" .. node_type .. "%s+([%w_]+)")
              or text:match("^%s*fn%s+([%w_]+)")
              or text:match("^%s*struct%s+([%w_]+)")
              or text:match("^%s*enum%s+([%w_]+)")
              or text:match("^%s*impl%s+([%w_]+)")
              or text:match("^%s*trait%s+([%w_]+)")
              or text:match("^%s*mod%s+([%w_]+)")
              or text:match("^%s*namespace%s+([%w_]+)")
              or text:match("^%s*let%s+([%w_]+)")
              or text:match("^%s*const%s+([%w_]+)")
              or text:match("^%s*for%s+([%w_]+)")
              or text:match("^%s*if%s+(.+)%s*{")
              or text:match("^%s*while%s+(.+)%s*{")
              or text:match("^%s*match%s+(.+)%s*{")
              or text:match("^%s*([%w_]+)%s*=")
          end

          -- 处理控制流语句的显示
          if node_type == "if_statement" or node_type == "if_expression" then
            name = name ~= "" and "if " .. name or "if"
          elseif node_type == "for_statement" then
            name = name ~= "" and "for " .. name or "for"
          elseif node_type == "while_statement" then
            name = name ~= "" and "while " .. name or "while"
          elseif node_type == "loop_expression" then
            name = "loop"
          elseif node_type == "match_expression" then
            name = name ~= "" and "match " .. name or "match"
          elseif node_type == "else_clause" then
            name = "else"
          elseif node_type == "case_clause" then
            name = name ~= "" and "case " .. name or "case"
          end

          if name and #name > 0 then
            -- 缩短过长名称
            local max_len = 18
            if #name > max_len then
              name = name:sub(1, max_len - 2) .. ".."
            end
            table.insert(context, 1, {
              text = node_types[node_type].icon .. " " .. name,
              color = node_types[node_type].color,
              priority = node_types[node_type].priority,
            })
          end
        end
        node = node:parent()
      end

      -- 拼接成导航路径，不做截断
      if #context > 0 then
        local parts = {}
        for _, item in ipairs(context) do
          -- 创建临时高亮组
          local hl_group = "CodeContext" .. item.color:gsub("#", "")
          vim.api.nvim_set_hl(0, hl_group, { fg = item.color, bg = colors.bg })
          table.insert(parts, "%#" .. hl_group .. "#" .. item.text .. "%*")
        end
        -- 箭头颜色
        local arrow_hl = "CodeContextArrow"
        vim.api.nvim_set_hl(0, arrow_hl, { fg = colors.fg, bg = colors.bg })
        return table.concat(parts, " %#" .. arrow_hl .. "#→%* ")
      end
      return ""
    end

    -- 代码导航添加到顶部 winbar 居中
    ins_winbar({
      function()
        return "%=" -- 左边内容结束
      end,
      padding = 0,
    })

    ins_winbar({
      get_code_context,
      cond = function()
        return conditions.buffer_not_empty() and conditions.hide_in_width()
      end,
      color = function()
        return { fg = colors.fg, bg = colors.bg }
      end,
      padding = 0,
    })

    ins_winbar({
      function()
        return "%=" -- 右边内容开始
      end,
      padding = 0,
    })

    -- 原有左侧组件
    ins_left({
      "filename",
      cond = conditions.buffer_not_empty,
      color = { fg = colors.fn_method, gui = "bold" },
    })

    ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })

    ins_left({
      "diagnostics",
      sources = { "nvim_diagnostic" },
      symbols = { error = " ", warn = " ", info = " " },
      diagnostics_color = {
        color_error = { fg = colors.if_stmt }, -- 使用if的红色作为错误色
        color_warn = { fg = colors.for_stmt }, -- 使用for的橙色作为警告色
        color_info = { fg = colors.match_stmt }, -- 使用match的青色作为信息色
      },
    })

    -- Add components to right sections
    ins_right({
      "o:encoding", -- option component same as &encoding in viml
      fmt = string.upper, -- I'm not sure why it's upper case either ;)
      cond = conditions.hide_in_width,
      color = { fg = colors.green, gui = "bold" },
    })

    ins_right({
      "fileformat",
      fmt = string.upper,
      icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
      color = { fg = colors.green, gui = "bold" },
    })

    ins_right({ "branch", icon = "", color = { fg = colors.violet, gui = "bold" } })

    ins_right({
      "diff",
      symbols = { added = " ", modified = "󱗜 ", removed = "󰍵 " },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    })

    ins_right({
      function()
        return " "
      end,
      color = { fg = colors.blue },
      padding = { left = 1 },
    })

    -- Now don't forget to initialize lualine
    lualine.setup(config)
  end,
}
