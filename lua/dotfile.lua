-- my config
vim.o.number = true
vim.o.rnu = true
vim.o.scrolloff = 6
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

vim.cmd([[
	set encoding=UTF-8
	set t_Co=256
]])

-- mykey
vim.api.nvim_set_keymap("n", "W", ":w<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "Q", ":q<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<space>e", ":NvimTreeToggle<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "ff", "<cmd>Telescope find_files<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "fg", "<cmd>Telescope live_grep<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "er", "<cmd>Telescope diagnostics<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "mk", "<cmd>Telescope marks<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "-", "<C-w>h", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "=", "<C-w>l", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-j>", ":bn<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<C-k>", ":bp<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "+", ":vertical res+5<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "_", ":vertical res-5<CR>", {noremap = true, silent = true})

--color
vim.cmd([[colorscheme gruvbox]])
--saga key
vim.api.nvim_set_keymap("n", "K", ":Lspsaga hover_doc<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "rn", ":Lspsaga rename<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "gd", ":Lspsaga preview_definition<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "[e", ":Lspsaga diagnostic_jump_next<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "]e", ":Lspsaga diagnostic_jump_prev<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "ca", ":Lspsaga code_action<CR>", {noremap = true, silent = true})

--saga terminal
vim.cmd([[ nnoremap <silent> tr :Lspsaga open_floaterm<CR>]])
vim.cmd([[ nnoremap <silent> tl  <cmd>lua require('lspsaga.floaterm').open_float_terminal('lazygit')<CR> ]])
vim.cmd([[ tnoremap <silent> tr <C-\><C-n>:Lspsaga close_floaterm<CR> ]])

-- format
vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.css,*.js,*.jsx,*.tsx,*.lua,*.html,*.go FormatWrite
augroup END
]],
  true
)

-- no background
vim.cmd([[
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
]])

-- vim-vsnip
vim.cmd(
  [[
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript','html','css']
let g:vsnip_filetypes.typescriptreact = ['typescript','html','css']
]]
)

-- debuger
vim.cmd(
  [[
    nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
    nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
    nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
    nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
    nnoremap <silent> <space>b :lua require'dap'.toggle_breakpoint()<CR>
    nnoremap <silent> <space>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
    nnoremap <silent> <space>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
    nnoremap <silent> <space>dr :lua require'dap'.repl.open()<CR>
    nnoremap <silent> <space>dl :lua require'dap'.run_last()<CR>


]]
)
-- fcitx5 
vim.cmd([[
autocmd InsertLeave * :silent !fcitx5-remote -c " 退出插入模式时禁用输入法
autocmd BufCreate *  :silent !fcitx5-remote -c " 创建 Buf 时禁用输入法
autocmd BufEnter *  :silent !fcitx5-remote -c " 进入 Buf 时禁用输入法
autocmd BufLeave *  :silent !fcitx5-remote -c " 离开 Buf 时禁用输入法
]])
