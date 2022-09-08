-- my config
vim.g.mapleader = " "
vim.o.number = true
vim.o.rnu = true
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
local opts = {noremap = true, silent = true}
-- mykey
-- LuaFormatter off
vim.api.nvim_set_keymap("n", "W", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "Q", ":q<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "ff", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
	{ noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "er", "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "mk", "<cmd>Telescope marks<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "fb", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dV", ":DiffviewOpen<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>dC", ":DiffviewClose<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "-", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "=", "<C-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":bn<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":bp<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "+", ":vertical res+5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "_", ":vertical res-5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F2>", ":LspRestart<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-g>", ":LazyGit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<enter>", ":noh<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)


-- LuaFormatter on

-- LuaFormatter off
vim.api.nvim_set_keymap("n", "<leader>k", ":Lspsaga hover_doc<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>rn", ":Lspsaga rename<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", ":Lspsaga preview_definition<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[e", ":Lspsaga diagnostic_jump_next<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]e", ":Lspsaga diagnostic_jump_prev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "ca", ":Lspsaga code_action<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>h", ":Lspsaga show_line_diagnostics<CR>", { noremap = true, silent = true })



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

vim.cmd([[
	augroup remember_folds
		autocmd!
		autocmd BufWinLeave *.* mkview
		autocmd BufWinEnter *.* silent! loadview
	augroup END
]])
