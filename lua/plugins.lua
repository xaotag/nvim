return require("packer").startup(
  function(use)
    -- packer
    use "wbthomason/packer.nvim"
    -- lsp
    use "onsails/lspkind-nvim"
    use "neovim/nvim-lspconfig" -- Collection of configurations for built-in LSP client
    use "hrsh7th/nvim-cmp" -- Autocompletion plugin
    use "hrsh7th/cmp-nvim-lsp" -- LSP source for nvim-cmp
    use "saadparwaiz1/cmp_luasnip" -- Snippets source for nvim-cmp
    use "L3MON4D3/LuaSnip" -- Snippets plugin
    -- lsp install
    use "williamboman/nvim-lsp-installer"
    -- tree
    use "nvim-treesitter/nvim-treesitter"
    use {
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons" -- optional, for file icon
      },
      config = function()
        require "nvim-tree".setup {}
      end
    }
    use {"tami5/lspsaga.nvim", branch = "nvim6.0"}
    --git
    use {
      "lewis6991/gitsigns.nvim",
      requires = {
        "nvim-lua/plenary.nvim"
      }
      -- tag = 'release' -- To use the latest release
    }
    use {"morhetz/gruvbox"}
    -- use {"maxmellon/vim-jsx-pretty"}
    use {
      "nvim-telescope/telescope.nvim",
      requires = {{"nvim-lua/plenary.nvim"}}
    }
    use "mhartington/formatter.nvim"

  end
)
