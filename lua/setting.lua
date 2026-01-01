-- my config
-- vim.g.have_nerd_font = true
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autochdir = true
vim.opt.scrolloff = 6
vim.opt.winborder = "rounded"
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.lsp.inlay_hint.enable(true)

-- 全局 UI 边框配置
local border = "rounded"

-- LSP 悬停文档和签名帮助的边框
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = border,
})

-- 诊断浮动窗口的边框
vim.diagnostic.config({
  float = {
    border = border,
    source = "always",
    header = "",
    prefix = "",
  },
})

local keymap = vim.keymap.set
local function map(lhs, rhs, desc)
  keymap("n", lhs, rhs, { silent = true, desc = desc })
end

-- 文件操作
map("W", "<cmd>w<CR>", "保存文件")
map("Q", "<cmd>q<CR>", "退出窗口")
-- 窗口导航
map("-", "<C-w>h", "左移窗口焦点")
map("=", "<C-w>l", "右移窗口焦点")
-- 缓冲区导航
map("<C-j>", "<cmd>bnext<CR>", "下一个缓冲区")
map("<C-k>", "<cmd>bprevious<CR>", "上一个缓冲区")
-- 窗口大小调整
map("+", "<cmd>vertical resize +5<CR>", "增加窗口宽度")
map("_", "<cmd>vertical resize -5<CR>", "减少窗口宽度")
-- LSP重启
map("<F9>", "<cmd>LspRestart<CR>", "重启LSP")
-- 清除搜索高亮
map("<enter>", "<cmd>noh<CR>", "清除搜索高亮")
-- LuaFormatter on

-- vim-vsnip
vim.g.vsnip_filetypes = {}
vim.g.vsnip_filetypes.javascriptreact = { "javascript", "html", "css" }
vim.g.vsnip_filetypes.typescriptreact = { "typescript", "html", "css" }

-- suffix
local suffixesadd_group = vim.api.nvim_create_augroup("suffixesadd-typescript", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = suffixesadd_group,
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function()
    local suffixes = vim.opt_local.suffixesadd:get()
    if not vim.tbl_contains(suffixes, ".ts") then
      vim.opt_local.suffixesadd:append({ ".ts" })
    end
    if not vim.tbl_contains(suffixes, ".tsx") then
      vim.opt_local.suffixesadd:append({ ".tsx" })
    end
  end,
})

-- 修复旗帜
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
})
