require("toggleterm").setup {}
local Terminal = require('toggleterm.terminal').Terminal
local ranger =
    Terminal:new({cmd = "ranger", hidden = true, direction = "float"})
local term = Terminal:new({direction = "float", border = "double"})

function _ranger_toggle() ranger:toggle() end

function _term_toggle() term:toggle() end

vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>lua _ranger_toggle()<CR>",
                        {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>lua _term_toggle()<CR>",
                        {noremap = true, silent = true})
