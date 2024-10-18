return {
	"glepnir/lspsaga.nvim",
	config = function()
		require("lspsaga").setup({
			lightbulb = {
				enable = false,
			},
			symbol_in_winbar = {
				enable = false,
			},
			ui = { use_nerd = true },
			outline = {
				layout = "float",
			},
		})
	end,
	vim.keymap.set("n", "<leader>k", "<cmd>Lspsaga hover_doc<cr>", { desc = "Hover Doc" }),
	vim.keymap.set("n", "<leader>l", "<cmd>Lspsaga show_line_diagnostics<cr>", { desc = "Show Line Diagnostics" }),
	vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", { desc = "Code Action" }),
	vim.keymap.set("n", "<leader>r", "<cmd>Lspsaga rename<cr>", { desc = "Rename" }),
	vim.keymap.set("n", "<leader>f", "<cmd>Lspsaga lsp_finder<cr>", { desc = "Finder" }),
}
