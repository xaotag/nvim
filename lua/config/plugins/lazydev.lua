return {

	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			{ path = "lua/vim", words = { "vim%." } },
		},
	},
}
