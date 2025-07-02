return {
	{ "RaafatTurki/hex.nvim" },
	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
		config = true,
	},

	-- UI {{{
	{
		"FlynnD273/vim-moonfly-colors",
		as = "moonfly",
		lazy = false,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },

		lazy = true,
	},

	-- }}}

	-- Telescope and co. {{{
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim" },

		lazy = true,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",

		lazy = true,
	},
	{
		"BurntSushi/ripgrep",
		lazy = true,
	},
	{
		"sharkdp/fd",
		lazy = true,
	},

	-- }}}

	-- Coding {{{
	{
		"goerz/jupytext.vim",
		lazy = true,
	},
	{
		"mfussenegger/nvim-jdtls",
		lazy = true,
	},
	{
		"tpope/vim-commentary",
		lazy = true,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",

		lazy = true,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = true,
	},
	{
		"j-hui/fidget.nvim",
		lazy = false,
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		lazy = false,
	},
	{
		"hrsh7th/cmp-buffer",
		lazy = false,
	},
	{
		"hrsh7th/cmp-path",
		lazy = false,
	},
	{
		"hrsh7th/cmp-cmdline",
		lazy = false,
	},
	{
		"saadparwaiz1/cmp_luasnip",
		lazy = false,
	},
	{
		"hrsh7th/cmp-nvim-lsp-signature-help",
		lazy = true,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		cmd = { "Mason", "MasonLog", "MasonUpdate", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },

		opts = {},
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {}
			},
			"neovim/nvim-lspconfig",
		},

		lazy = true,
	},
	{
		"Hoffs/omnisharp-extended-lsp.nvim",
		lazy = true,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
	},
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",

		lazy = true,
	},
	{
		"filipdutescu/renamer.nvim",
		branch = "master",
		dependencies = "nvim-lua/plenary.nvim",

		lazy = true,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio" },

		lazy = true,
	},

	-- }}}

	-- Convenience {{{
	{ "FlynnD273/vim-autosource" },
	{
		"ThePrimeagen/harpoon",
		lazy = true,
	},
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		lazy = true,
	},
	{
		"tpope/vim-fugitive",
		cmd = "Git",
		lazy = true,
	},
	{
		"vladdoster/remember.nvim",
		lazy = false
	},
	{
		"numToStr/Navigator.nvim",
		config = function()
			require("Navigator").setup()
		end,
		lazy = false,
	},
	{
		"epwalsh/obsidian.nvim",
		branch = "main",

		lazy = true,
	},
	{
		"folke/trouble.nvim",
		lazy = true,
	},
	{ "nvim-tree/nvim-web-devicons" },
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		config = function() vim.g.mkdp_filetypes = { "markdown" } end,
		ft = { "markdown" },

		lazy = true,
	},
	-- }}}
}
