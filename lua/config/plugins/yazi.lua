return {
	{
		"mikavilpas/yazi.nvim",
		dependencies = { "folke/snacks.nvim", "MagicDuck/grug-far.nvim" },
		event = "VeryLazy",
		keys = {
			{
				"<leader>e",
				function()
					require("yazi").yazi(nil, vim.fn.getcwd())
				end,
			},
		},
		opts = {
			open_for_directories = false,
			integrations = {
				grep_in_directory = "snacks.picker",
				grep_in_selected_files = "snacks.picker",
			},
		},
	},
}
