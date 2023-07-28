local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use { 'FlynnD273/vim-moonfly-colors', as = 'moonfly', }
  use 'tpope/vim-commentary'
	use 'lukas-reineke/indent-blankline.nvim'
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons' }
	}
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.x',
    requires = 'nvim-lua/plenary.nvim',
  }
	use {
		'j-hui/fidget.nvim',
		tag = "legacy",
	}
	use {
		'nvim-telescope/telescope-fzf-native.nvim',
		run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
	}
  use 'BurntSushi/ripgrep'
  use 'sharkdp/fd'
  use 'ThePrimeagen/harpoon'
  use 'mbbill/undotree'
  use 'tpope/vim-fugitive'
  use { 
		'vladdoster/remember.nvim',
		config = [[ require('remember') ]],
	}

	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'saadparwaiz1/cmp_luasnip'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'L3MON4D3/LuaSnip'
	use {
		'filipdutescu/renamer.nvim',
		branch = 'master',
		requires = 'nvim-lua/plenary.nvim',
	}
	-- use 'github/copilot.vim'
	use 'Hoffs/omnisharp-extended-lsp.nvim'
	use 'christoomey/vim-tmux-navigator'
	use 'xiyaowong/transparent.nvim'
	use { 'FlynnD273/obsidian.nvim', branch = 'main', }
	use {
		'folke/trouble.nvim',
		requires = 'nvim-tree/nvim-web-devicons',
	}
	use 'theHamsta/nvim-dap-virtual-text'
	use 'smjonas/live-command.nvim'
	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
	use_rocks 'luafilesystem'

	-- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
	end
end)
