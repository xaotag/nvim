local dap = require("dap")
vim.fn.sign_define('DapBreakpoint',
                   {text = '🐞', texthl = '', linehl = '', numhl = ''})
-- keymap
vim.cmd([[
	nnoremap <silent> <F1> :lua require'dap'.continue()<CR>
  nnoremap <silent> <F2> :lua require'dap'.step_over()<CR>
	nnoremap <silent> <F3> :lua require'dap'.step_into()<CR>
	nnoremap <silent> <F4> :lua require'dap'.step_out()<CR>
	nnoremap <silent> <F5> :lua require'dap'.toggle_breakpoint()<CR>
	nnoremap <silent> <F6> :lua require'dap'.close()<CR>
	nnoremap <silent> <space>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
	nnoremap <silent> <space>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
	nnoremap <silent> <space>dr :lua require'dap'.repl.open()<CR>
	nnoremap <silent> <space>dl :lua require'dap'.run_last()<CR>
]])

-- debug go
require('debuger.debug_go')

-- dap ui
require('debuger.dap_ui')
require("nvim-dap-virtual-text").setup()
