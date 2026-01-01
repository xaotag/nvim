# AGENTS.md - Neovim Configuration

This document provides guidelines for working with this Neovim configuration codebase.

## Project Structure

```
.
├── init.lua              # Main entry point
├── lua/
│   ├── setting.lua       # Core Neovim settings and keymaps
│   ├── fold.lua          # Folding configuration
│   └── config/
│       ├── lazy/        # Lazy.nvim bootstrap
│       └── plugins/     # Plugin configurations
└── after/               # Post-initialization scripts
```

## Build/Lint/Test Commands

### Formatting
- **Format current file**: `:Format` or `:lua vim.lsp.buf.format()`
- **Auto-format on save**: Enabled via conform.nvim
- **Lua formatter**: stylua (configured in conform.nvim)
- **Run stylua manually**: `stylua path/to/file.lua`

### Linting
- **LSP diagnostics**: `:lua vim.diagnostic.open_float()` or `:TroubleToggle`
- **Check Lua syntax**: `:luafile %` to reload current file

### Testing
- **No test framework** - This is a Neovim configuration, not a library
- **Test changes**: Reload Neovim with `:source $MYVIMRC` or restart Neovim
- **Debug LSP**: Use `:LspInfo` and `:LspLog` commands

### Plugin Management
- **Update plugins**: `:Lazy sync`
- **Check for updates**: `:Lazy check`
- **Clean unused plugins**: `:Lazy clean`

## Code Style Guidelines

### Imports
```lua
-- Use local variables for requires
local lualine = require("lualine")
local dap, dapui = require("dap"), require("dapui")

-- Group related requires together
local map = vim.keymap.set
local opts = { silent = true }
```

### Formatting
- **Indentation**: 2 spaces (no tabs)
- **Line length**: No explicit limit, but keep lines readable
- **Braces**: Same line for opening braces
- **Trailing commas**: Not used in this codebase
- **Spacing**: Use spaces around operators and after commas

### Variable Naming
- **Local variables**: `lowercase_with_underscores`
- **Constants**: `UPPER_CASE` (rarely used)
- **Plugin configs**: Use descriptive names like `colors`, `conditions`, `config`
- **Temporary variables**: Short names like `opts`, `bufnr`, `client`

### Function Style
```lua
-- Use anonymous functions for callbacks
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

-- Define helper functions at top of scope
local function check_git_workspace()
  local filepath = vim.fn.expand("%:p:h")
  local gitdir = vim.fn.finddir(".git", filepath .. ";")
  return gitdir and #gitdir > 0 and #gitdir < #filepath
end
```

### Error Handling
- **Minimal error handling** - Neovim configs typically fail gracefully
- **Use vim.notify for errors**: `vim.notify("Error message", vim.log.levels.ERROR)`
- **Check plugin availability**: Use `pcall(require, "plugin")`

### Plugin Configuration Pattern
```lua
return {
  "author/plugin-name",
  config = function()
    require("plugin").setup({
      -- Configuration options
      option1 = value1,
      option2 = value2,
    })
    
    -- Additional setup like keymaps
    vim.keymap.set("n", "<leader>p", function()
      require("plugin").action()
    end, { desc = "Plugin action" })
  end,
}
```

### Keymap Conventions
- **Leader key**: Space (` `)
- **Local leader**: Backslash (`\`)
- **API**: Use `vim.keymap.set` only
- **Options**: Include `{ silent = true, desc = "..." }` by default
- **Descriptions**: Add `desc` field for all non-trivial mappings
- **Group related keymaps**: Keep plugin keymaps together in config

### Neovim API Usage
- **Prefer vim.keymap.set**: Over `vim.api.nvim_set_keymap`
- **Use vim.opt for options**: Over `vim.o`, `vim.wo`, `vim.bo` when appropriate
- **Prefer Lua API over vim.cmd**: Use `vim.api.nvim_create_autocmd`, `vim.opt_local`, `vim.diagnostic.config` first
- **vim.fn for Vim functions**: When Neovim API doesn't have equivalent

### Neovim 0.10+ Guidelines
- **LSP setup**: Prefer `vim.lsp.config()` + `vim.lsp.enable()`
- **Diagnostics signs**: Prefer `vim.diagnostic.config({ signs = { text = ... } })`
- **Treesitter text extraction**: Use `vim.treesitter.get_node_text(node, bufnr)`
- **Autocmds**: Always create and use `augroup` to avoid duplicate registrations
- **Buffer-local options**: Prefer `vim.opt_local` in autocmd callbacks

### Comments
- **Chinese comments allowed**: This codebase uses Chinese comments
- **Keep comments concise**: Explain why, not what
- **Section headers**: Use `-- Section Name` format
- **TODO comments**: Use `-- TODO:` prefix

### File Organization
- **One plugin per file**: In `lua/config/plugins/`
- **Core settings**: In `lua/setting.lua`
- **Plugin imports**: Via `lua/config/plugins/init.lua`
- **Post-config**: Use `after/` directory for late-loading configs
- **Plugin-specific keymaps**: Define in that plugin's config block, not in `init.lua`

## Development Workflow

1. **Make changes** to Lua files
2. **Test immediately**: `:luafile %` to reload current file
3. **Format code**: `:Format` or let conform.nvim auto-format on save
4. **Check for errors**: `:messages` and LSP diagnostics
5. **Reload full config**: `:source $MYVIMRC` or restart Neovim

## Common Tasks

### Adding a New Plugin
1. Create file in `lua/config/plugins/plugin_name.lua`
2. Follow plugin configuration pattern
3. Import in `lua/config/plugins/init.lua`
4. Run `:Lazy sync`

### Debugging Issues
1. Check `:messages` for errors
2. Use `:LspLog` for LSP issues
3. Check `:Lazy profile` for plugin load times
4. Disable plugins temporarily to isolate issues

### Performance Optimization
1. Use `:Lazy profile` to identify slow plugins
2. Lazy-load plugins when possible
3. Avoid expensive operations in autocmds
4. Use `vim.schedule` for deferred operations

## Notes for AI Agents

- This is a **Neovim configuration**, not a library or application
- Focus on **user experience** and **editor functionality**
- Changes should be **backward compatible** with existing workflow
- Test changes in actual Neovim session
- Follow existing patterns in the codebase
- Chinese comments are acceptable and present in the codebase
