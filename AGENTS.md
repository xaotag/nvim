# AGENTS.md - Neovim 配置仓库指南

## 项目概述

这是 Neovim 的个性化配置仓库，使用 Lua 编写，基于 lazy.nvim 插件管理器。

## 目录结构

```
init.lua              # 入口文件
lua/
  config/
    lazy/init.lua     # lazy.nvim 引导与初始化
    pack.lua          # vim.pack 备用插件管理器
    plugins/          # 各插件配置文件（每个插件一个文件）
  setting.lua         # 全局设置与按键映射
  fold.lua            # 代码折叠配置
after/ftplugin/       # 文件类型特定配置
```

## 构建/测试/格式化命令

本项目是 Neovim 配置，无传统编译/测试流程。

### 格式化

- **Lua 格式化**: 使用 `stylua`，保存时自动执行（conform.nvim）
- 手动运行: `stylua --indent-type Spaces --indent-width 2 .`
- 配置: `.stylua.toml` (Spaces, 2 缩进)

### 校验

- **Lua 静态分析**: `.luarc.json` 配置 lua-language-server
- 禁用规则: `redefined-local`, `lowercase-global`, `unused-local`, `deprecated`, `unused-function`
- 全局变量: `vim`, `dap`, `cmp`, `null_ls`, `left`, `init_options`, `chadtree_settings`

### 验证配置

- `nvim --headless "+Lazy! sync" +qa` - 同步插件
- `nvim --headless -c "lua print('OK')" +qa` - 快速检查配置语法

## 代码风格

### 命名约定

- **模块变量**: 使用 `local M = {}` 模式导出模块
- **局部变量**: snake_case（如 `local keymap = vim.keymap.set`）
- **函数名**: snake_case（如 `clone()`, `install_plugins()`）
- **描述字符串**: 中文（按键映射的 desc 字段）

### 缩进与格式

- 2 空格缩进（不使用 Tab）
- 行宽无硬性限制，保持可读即可
- 保存时自动格式化（conform.nvim BufWritePre autocmd）

### 插件配置模板

```lua
return {
  "author/plugin-name",
  dependencies = { "optional/dep" },  -- 可选
  event = "InsertEnter",              -- 可选，延迟加载
  config = function()
    require("plugin").setup({})
  end,
}
```

### 按键映射约定

- 使用 `vim.keymap.set(mode, lhs, rhs, opts)`
- 每个映射必须带 `desc` 描述（中文）
- 默认 `silent = true`
- 全局映射定义在 `setting.lua`
- Buffer-local 映射在 LspAttach 等 autocmd 中定义

### 错误处理

- 插件加载使用 `pcall(require, ...)` 安全加载
- 插件安装时检查 `vim.v.shell_error`
- 使用 `vim.uv or vim.loop` 兼容不同 Neovim 版本

### 导入规范

- 使用 `require("config.plugins.xxx")` 加载插件配置
- 模块路径相对于 `lua/` 目录
- 避免全局变量，优先使用 `local`

### Autocmd 组织

- 使用 `vim.api.nvim_create_augroup()` 创建命名组
- 每组 `{ clear = true }` 防止重复定义
- 常见组名: `lsp-attach`, `lsp-inlay-hints`, `ts-organize-imports`

## 已配置的语言服务器

emmylua_ls, vtsls, html, emmet_language_server, gopls, pyright, clangd, jsonls
（rust-analyzer 由 rustaceanvim 管理）

## 格式化规则

| 文件类型 | 格式化工具 |
|---------|-----------|
| Lua     | stylua (Spaces, 2) |
| Python  | isort + black |
| Rust    | rustfmt |
| JS/TS/JSON/YAML | deno_fmt |

## 注意事项

- 修改插件配置后重启 Neovim 或运行 `<F9>` (LspRestart)
- YAML 文件中 mihomo 相关路径禁用自动格式化
- TS/TSX 文件保存时自动执行 organizeImports
