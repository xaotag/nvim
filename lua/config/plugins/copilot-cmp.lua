return {
	"zbirenbaum/copilot-cmp",
	alter = { "copilot.lua" },
	config = function()
		require("copilot_cmp").setup()
	end,
}
