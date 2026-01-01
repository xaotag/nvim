-- Neovim 0.12 vim.pack 插件管理器
local M = {}

-- 插件安装目录
local pack_dir = vim.fn.stdpath("data") .. "/site/pack/vendor/opt"
vim.fn.mkdir(pack_dir, "p")
vim.opt.packpath:prepend(pack_dir)

-- 插件配置目录
local plugins_dir = vim.fn.stdpath("config") .. "/lua/config/plugins"

-- 克隆单个插件
local function clone(repo)
  local path = pack_dir .. "/" .. repo
  if not (vim.uv or vim.loop).fs_stat(path) then
    vim.api.nvim_echo({
      { "Installing " .. repo .. "...\n", "Question" },
    }, true, {})
    local out = vim.fn.system({
      "git", "clone", "--depth=1", "--filter=blob:none",
      "https://github.com/" .. repo .. ".git",
      path,
    })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to install " .. repo .. ": " .. out, "ErrorMsg" },
      }, true, {})
    end
  end
end

-- 从配置中提取所有插件并安装
local function install_plugins()
  local files = vim.fn.glob(plugins_dir .. "/*.lua", false, true)
  local installed = {}

  for _, file in ipairs(files) do
    local ok, config = pcall(require, "config.plugins." .. vim.fn.fnamemodify(file, ":t:r"))
    if not ok or type(config) ~= "table" then
      goto continue
    end

    local function process(p)
      if type(p) ~= "table" or type(p[1]) ~= "string" then
        return
      end
      if not installed[p[1]] then
        clone(p[1])
        installed[p[1]] = true
      end
      if p.dependencies then
        for _, dep in ipairs(p.dependencies) do
          process(type(dep) == "string" and { dep } or dep)
        end
      end
    end

    -- 单个插件或插件列表
    if type(config[1]) == "table" then
      for _, p in ipairs(config) do
        process(p)
      end
    else
      process(config)
    end

    ::continue::
  end
end

-- 加载单个插件配置
local function load_plugin_config(config)
  if type(config) ~= "table" or type(config[1]) ~= "string" then
    return
  end

  -- 加载插件
  vim.pack.add(config[1])

  -- 加载依赖
  if config.dependencies then
    for _, dep in ipairs(config.dependencies) do
      vim.pack.add(type(dep) == "string" and dep or dep[1])
    end
  end

  -- 执行配置
  if config.config then
    config.config()
  end
end

-- 按优先级加载插件
local function load_plugins()
  -- 优先级 1: 基础插件（必须最先加载）
  local priority_plugins = {
    "blink_cmp",      -- 补全，LSP 依赖其 capabilities
    "lazydev",        -- Lua 开发支持
    "treesitter",     -- 语法解析
    "mini_nvim",      -- 基础 UI 组件
    "theme",          -- 主题
  }

  local files = vim.fn.glob(plugins_dir .. "/*.lua", false, true)
  local loaded = {}

  -- 先加载优先级插件
  for _, name in ipairs(priority_plugins) do
    for _, file in ipairs(files) do
      if vim.fn.fnamemodify(file, ":t:r") == name then
        local ok, config = pcall(require, "config.plugins." .. name)
        if ok and type(config) == "table" then
          if type(config[1]) == "table" then
            for _, p in ipairs(config) do
              load_plugin_config(p)
            end
          else
            load_plugin_config(config)
          end
          loaded[name] = true
        end
        break
      end
    end
  end

  -- 加载其余插件
  for _, file in ipairs(files) do
    local name = vim.fn.fnamemodify(file, ":t:r")
    if not loaded[name] then
      local ok, config = pcall(require, "config.plugins." .. name)
      if ok and type(config) == "table" then
        if type(config[1]) == "table" then
          for _, p in ipairs(config) do
            load_plugin_config(p)
          end
        else
          load_plugin_config(config)
        end
      end
    end
  end
end

function M.setup()
  install_plugins()
  load_plugins()
end

return M
