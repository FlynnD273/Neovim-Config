local cmp = require'cmp'
-- local luasnip = require'luasnip'

-- vim.keymap.set('i', '<C-m>', 'noop')

cmp.setup({
	view = {
		entries = "native"
	},
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),		

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),

		['<M-k>'] = cmp.mapping.scroll_docs(-4),
		['<M-j>'] = cmp.mapping.scroll_docs(4),
		['<M-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		-- { name = 'vsnip' }, -- For vsnip users.
		{ name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
		{ name = 'path' },
		{ name = 'buffer' },
	})
})

-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
-- 	sources = cmp.config.sources({
-- 		{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
-- 	}, {
-- 		{ name = 'buffer' },
-- 	})
-- })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	view = {
		entries = "custom"
	},
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	view = {
		entries = "custom"
	},
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' },
		{ name = 'cmdline' },
	})
})

-- If you want insert `(` after select function or method item
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- local cmp = require('cmp')
-- cmp.event:on(
--   'confirm_done',
--   cmp_autopairs.on_confirm_done()
-- )

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').lua_ls.setup { -- https://luals.github.io/#neovim-install
	capabilities = capabilities,
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {'vim', 'require' },
			},
			workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
				-- Do not send telemetry data containing a randomized but unique identifier
        enable = false,
      },
		},
	},
}
require('lspconfig').csharp_ls.setup { -- dotnet tool install --global csharp-ls
	capabilities = capabilities,
	root_dir = function(startpath)
		local lspconfig = require('lspconfig')
		return lspconfig.util.root_pattern("*.sln")(startpath)
				or lspconfig.util.root_pattern("*.csproj")(startpath)
				or lspconfig.util.root_pattern("*.fsproj")(startpath)
				or lspconfig.util.root_pattern(".git")(startpath)
	end,
}
require('lspconfig').pyright.setup { capabilities = capabilities } -- npm i -g pyright
require('lspconfig').gdscript.setup { capabilities = capabilities } -- comes with Godot
require('lspconfig').html.setup { capabilities = capabilities } -- npm i -g vscode-langservers-extracted
require('lspconfig').rust_analyzer.setup { capabilities = capabilities } -- rustup component add rust-analyzer
require('lspconfig').tsserver.setup { capabilities = capabilities } -- npm i -g typescript-language-server typescript
require'lspconfig'.ccls.setup { capabilities = capabilities } -- https://github.com/MaskRay/ccls/wiki
require'lspconfig'.texlab.setup { capabilities = capabilities } -- cargo install texlab
require'lspconfig'.bashls.setup { capabilities = capabilities } -- npm i -g bash-language-server
