return {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"nvim-treesitter/nvim-treesitter", -- tree
	"neovim/nvim-lspconfig",
	"onsails/lspkind.nvim",
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-live-grep-args.nvim",
			"nvim-lua/plenary.nvim",
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
}
