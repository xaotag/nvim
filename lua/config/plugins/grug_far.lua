return {
	"MagicDuck/grug-far.nvim",
	config = function()
		vim.keymap.set({ "n", "x", "v" }, "<C-g>", function()
			require("grug-far").open({ visualSelectionUsage = "operate-within-range" })
		end, { desc = "grug-far: Search within range" })
		require("grug-far").setup({
			engine = "astgrep",
			--engine = 'ripgrep',
			-- engine = 'astgrep-rule'
		})
	end,
}
