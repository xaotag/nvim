require("telescope").setup({
	mappings = {
		i = {
			-- map actions.which_key to <C-h> (default: <C-/>)
			-- actions.which_key shows the mappings for your picker,
			-- e.g. git_{create, delete, ...}_branch for the git_branches picker
			["<C-h>"] = "which_key",
		},
	},
	defaults = {
		file_ignore_patterns = { "node_modules", "dist" },
		previewer = true,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
	},
	pickers = {
		find_files = { find_command = { "fd", "--type", "f", "--strip-cwd-prefix" } },
	},
})
require("telescope").load_extension("live_grep_args")
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep_args<CR>", opts)
