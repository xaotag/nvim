require("gomove").setup({
	map_defaults = false,
	reindent = true,
	undojoin = true,
	move_past_end_col = false,
})
local map = vim.api.nvim_set_keymap

map("n", "<S-h>", "<Plug>GoNSMLeft", {})
map("n", "<S-j>", "<Plug>GoNSMDown", {})
map("n", "<S-k>", "<Plug>GoNSMUp", {})
map("n", "<S-l>", "<Plug>GoNSMRight", {})

map("x", "<S-h>", "<Plug>GoVSMLeft", {})
map("x", "<S-j>", "<Plug>GoVSMDown", {})
map("x", "<S-k>", "<Plug>GoVSMUp", {})
map("x", "<S-l>", "<Plug>GoVSMRight", {})
