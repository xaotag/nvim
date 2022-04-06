local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap =
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

return require("packer").startup(
  function(use)
    -- packer
    use "wbthomason/packer.nvim"
    -- lsp
    use {"williamboman/nvim-lsp-installer"}
    use {"neovim/nvim-lspconfig"}
    use {"hrsh7th/cmp-path"}
    use {"hrsh7th/cmp-vsnip"}
    use {"hrsh7th/cmp-nvim-lsp"}
    use {"hrsh7th/nvim-cmp"}
    use {"hrsh7th/cmp-buffer"}
    use {"hrsh7th/vim-vsnip"}
    use {"hrsh7th/cmp-cmdline"}
    use {"hrsh7th/vim-vsnip-integ"}
    use "onsails/lspkind-nvim"
    use "nvim-treesitter/nvim-treesitter"
    -- tree
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
    --	viewdiff
    use {"sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim"}
    -- use {"maxmellon/vim-jsx-pretty"}
    use {
      "nvim-telescope/telescope.nvim",
      requires = {{"nvim-lua/plenary.nvim"}}
    }
    use "mhartington/formatter.nvim"
    -- 代码片段提示
    use "rafamadriz/friendly-snippets"
    --pairs
    use "windwp/nvim-autopairs"
    use "p00f/nvim-ts-rainbow"
    use "mg979/vim-visual-multi"
    -- nvim debuger
    use "mfussenegger/nvim-dap"
    use "theHamsta/nvim-dap-virtual-text"
    use "rcarriga/nvim-dap-ui"
    -- nvim debug go
    use "ryanoasis/vim-devicons"
    -- auto close tag
    use "windwp/nvim-ts-autotag"
    -- markdown 预览
    use {"ellisonleao/glow.nvim"}
		--lazygit 
		use 'kdheepak/lazygit.nvim'
		--代码块移动
		use 'booperlv/nvim-gomove'
		-- 主题
		use 'shaunsingh/nord.nvim'
		use {
			'nvim-lualine/lualine.nvim',
			requires = { 'kyazdani42/nvim-web-devicons', opt = true }
		}
		use 'Mofiqul/dracula.nvim'
    use {"morhetz/gruvbox"}
		-- Lua
		use {
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
		}
		use 'folke/tokyonight.nvim'
  end
)
