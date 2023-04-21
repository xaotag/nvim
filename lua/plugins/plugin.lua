return {
  {
    "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig"
  }, {"hrsh7th/cmp-path"}, {"hrsh7th/cmp-vsnip"}, {"hrsh7th/nvim-cmp"},
  {"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-buffer"}, {"hrsh7th/vim-vsnip"},
  {"hrsh7th/cmp-cmdline"}, {"hrsh7th/vim-vsnip-integ"}, "onsails/lspkind-nvim",
  {"nvim-treesitter/nvim-treesitter"}, -- tree
  {
    "kyazdani42/nvim-tree.lua",
    comment = "59bcb01d3bf58b810b9c48db56e558f3857110ad",
    dependencies = {
      "kyazdani42/nvim-web-devicons" -- optional, for file icon
    }
  }, ({"glepnir/lspsaga.nvim", branch = "main"}), -- git
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {"nvim-lua/plenary.nvim"}
    -- tag = 'release' -- To  the latest release
  }, --  {"maxmellon/vim-jsx-pretty"}
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {"nvim-lua/plenary.nvim"}, {'nvim-telescope/telescope-live-grep-raw.nvim'}
    }
  }, -- 代码片段提示
  "rafamadriz/friendly-snippets", -- pairs
  "windwp/nvim-autopairs", "p00f/nvim-ts-rainbow", "mg979/vim-visual-multi",
  -- nvim debuger
  "mfussenegger/nvim-dap", "theHamsta/nvim-dap-virtual-text",
  "rcarriga/nvim-dap-ui", "ryanoasis/vim-devicons", -- auto close tag
  "windwp/nvim-ts-autotag", -- markdown 预览
  {"ellisonleao/glow.nvim"}, -- lazygit
  'kdheepak/lazygit.nvim', -- 代码块移动
  'booperlv/nvim-gomove', -- 主题
  {'nvim-lualine/lualine.nvim'}, 'folke/tokyonight.nvim', -- Lua
  "jose-elias-alvarez/null-ls.nvim", "b0o/schemastore.nvim", -- 注释
  {"gennaro-tedesco/nvim-commaround"}, -- html change tag
  'AndrewRadev/tagalong.vim', -- code run
  'ray-x/go.nvim', 'ray-x/guihua.lua', -- recommanded if need floating window support
  {"NTBBloodbath/rest.nvim", dependencies = {"nvim-lua/plenary.nvim"}}
}
