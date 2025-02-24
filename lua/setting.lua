-- my config
-- vim.g.have_nerd_font = true
vim.g.mapleader = " "
vim.o.number = true
vim.o.rnu = true
vim.o.autochdir = true
vim.o.scrolloff = 6
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.wrap = false
vim.cmd([[
	set encoding=UTF-8
	set t_Co=256
	set termguicolors
]])
-- Enable inlay hints
vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = nil }))

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap("n", "W", ":w<CR>", opts)
keymap("n", "Q", ":q<CR>", opts)
keymap("n", "-", "<C-w>h", opts)
keymap("n", "=", "<C-w>l", opts)
keymap("n", "<C-j>", ":bn<CR>", opts)
keymap("n", "<C-k>", ":bp<CR>", opts)
keymap("n", "+", ":vertical res+5<CR>", opts)
keymap("n", "_", ":vertical res-5<CR>", opts)
keymap("n", "<F9>", ":LspRestart<CR>", opts)
keymap("n", "<enter>", ":noh<CR>", opts)
keymap("n", "<leader>rh", '<cmd>lua require("rest-nvim").run()<CR>', opts)
-- LuaFormatter on

-- vim-vsnip
vim.cmd([[
	let g:vsnip_filetypes = {}
	let g:vsnip_filetypes.javascriptreact = ['javascript','html','css']
	let g:vsnip_filetypes.typescriptreact = ['typescript','html','css']
]])

-- suffix
vim.cmd([[
autocmd FileType javascript,javascriptreact,typescript,typescriptreact set suffixesadd+=.ts,.tsx
]])

-- 修复旗帜

local signs = {
	Error = " ",
	Warn = " ",
	Hint = " ",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
