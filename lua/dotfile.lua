-- my config
vim.o.number = true
vim.o.shiftwidth = 2

-- mykey
vim.api.nvim_set_keymap("n", "W", ":w<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "Q", ":q<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<space>e", ":NvimTreeFindFileToggle<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "K", ":Lspsaga hover_doc<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "ff", "<cmd>Telescope find_files<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "fg", "<cmd>Telescope live_grep<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "er", "<cmd>Telescope diagnostics<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "mk", "<cmd>Telescope marks<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "-", "<C-w>h", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "=", "<C-w>l", {noremap = true, silent = true})

--color
vim.cmd([[colorscheme gruvbox]])
--terminal
vim.cmd([[ nnoremap <silent> tr :Lspsaga open_floaterm<CR>]])
vim.cmd([[ nnoremap <silent> lg  <cmd>lua require('lspsaga.floaterm').open_float_terminal('lazygit')<CR> ]])
vim.cmd([[ tnoremap <silent> tr <C-\><C-n>:Lspsaga close_floaterm<CR> ]])

--dotfile
vim.cmd([[
augroup Format
    autocmd!
    autocmd BufWritePost * FormatWrite
augroup END
]])


-- no background
vim.cmd([[
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
]])
