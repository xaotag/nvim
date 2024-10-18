-- my config
vim.g.have_nerd_font = true
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
--keymap("n", "<space>e", "<cmd>Yazi<CR>", opts)
keymap("n", "ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
keymap("n", "fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts)
keymap("n", "er", "<cmd>Telescope diagnostics<CR>", opts)
keymap("n", "mk", "<cmd>Telescope marks<CR>", opts)
keymap("n", "fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>dV", ":DiffviewOpen<CR>", opts)
keymap("n", "<leader>dC", ":DiffviewClose<CR>", opts)
keymap("n", "-", "<C-w>h", opts)
keymap("n", "=", "<C-w>l", opts)
keymap("n", "<C-j>", ":bn<CR>", opts)
keymap("n", "<C-k>", ":bp<CR>", opts)
keymap("n", "+", ":vertical res+5<CR>", opts)
keymap("n", "_", ":vertical res-5<CR>", opts)
keymap("n", "<F9>", ":LspRestart<CR>", opts)
keymap("n", "<C-g>", ":LazyGit<CR>", opts)
keymap("n", "<enter>", ":noh<CR>", opts)
keymap("n", "<leader>rh", '<cmd>lua require("rest-nvim").run()<CR>', opts)
keymap("n", "]e", vim.diagnostic.goto_next)
keymap("n", "[e", vim.diagnostic.goto_prev)
-- LuaFormatter on

-- vim-vsnip
vim.cmd([[
	let g:vsnip_filetypes = {}
	let g:vsnip_filetypes.javascriptreact = ['javascript','html','css']
	let g:vsnip_filetypes.typescriptreact = ['typescript','html','css']
]])

-- lazygit
vim.cmd([[
	let g:lazygit_floating_window_winblend = 0 " transparency of floating window
	let g:lazygit_floating_window_scaling_factor = 0.9 " scaling factor for floating window
	let g:lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
	let g:lazygit_floating_window_use_plenary = 0 " use plenary.nvim to manage floating window if available
	let g:lazygit_use_neovim_remote = 1 " fallback to 0 if neovim-remote is not installed
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
