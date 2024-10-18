require("telescope").setup({
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
