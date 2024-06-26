require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"lua",
		"rust",
		"go",
		"html",
		"css",
		"json",
		"yaml",
		"python",
		"javascript",
		"typescript",
		"tsx",
		"fish",
		"markdown",
	},
	sync_install = false,
	highlight = { enable = true }, -- , additional_vim_regex_highlighting = true},
	rainbow = {
		enable = true,
	},
	autotag = { enable = true },
})
