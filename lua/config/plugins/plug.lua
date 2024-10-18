return {
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/vim-vsnip",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/vim-vsnip-integ",
		},
	},
	{ "nvim-treesitter/nvim-treesitter" }, -- tree
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-raw.nvim",
		},
	}, -- 代码片段提示
	"mg979/vim-visual-multi", -- nvim debuger
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
	},
	"ryanoasis/vim-devicons", -- auto close tag
	"windwp/nvim-ts-autotag", -- markdown 预览
	"ellisonleao/glow.nvim", -- lazygit
	"kdheepak/lazygit.nvim", -- 代码块移动
	"booperlv/nvim-gomove", -- 主题
	"folke/tokyonight.nvim", -- Lua
	"b0o/schemastore.nvim", -- 注释
	"gennaro-tedesco/nvim-commaround", -- html change tag
	"AndrewRadev/tagalong.vim", -- code run
	"ray-x/go.nvim",
	"ray-x/guihua.lua", -- recommanded if need floating window support
	"nvimdev/lspsaga.nvim",
	"rafamadriz/friendly-snippets", -- pairs
	"windwp/nvim-autopairs",
}
