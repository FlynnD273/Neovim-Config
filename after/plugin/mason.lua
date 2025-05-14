require("mason").setup()
require("mason-lspconfig").setup()
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
lspconfig.gdscript.setup { capabilities = capabilities }
-- raco pkg install racket-langserver
lspconfig.racket_langserver.setup { capabilities = capabilities }
require 'lspconfig'.lua_ls.setup {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT'
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				}
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
				-- library = vim.api.nvim_get_runtime_file("", true)
			}
		})
	end,
	settings = {
		Lua = {}
	}
}
local path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
local root_file = vim.fs.find({ "*.sln", "*.csproj", "*.fsproj", ".git" },
	{ type = "file", path = path, upward = true })[1]
path = vim.fs.dirname(root_file)
lspconfig.omnisharp.setup {
	handlers = { ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
		["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
		["textDocument/references"] = require('omnisharp_extended').references_handler,
		["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
	},
	capabilities = capabilities,
	cmd = { "dotnet", vim.fn.stdpath "data" .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
	-- cmd = {[[/home/flynn/Downloads/omnisharp-linux-x64-net6.0/OmniSharp]]},
	settings = {
		FormattingOptions = {
			-- Enables support for reading code style, naming convention and analyzer
			-- settings from .editorconfig.
			EnableEditorConfigSupport = true,
			-- Specifies whether 'using' directives should be grouped and sorted during
			-- document formatting.
			OrganizeImports = true,
		},
		MsBuild = {
			-- If true, MSBuild project system will only load projects for files that
			-- were opened in the editor. This setting is useful for big C# codebases
			-- and allows for faster initialization of code navigation features only
			-- for projects that are relevant to code that is being edited. With this
			-- setting enabled OmniSharp may load fewer projects and may thus display
			-- incomplete reference lists for symbols.
			LoadProjectsOnDemand = nil,
		},
		RoslynExtensionsOptions = {
			-- Enables support for roslyn analyzers, code fixes and rulesets.
			EnableAnalyzersSupport = true,
			-- Enables support for showing unimported types and unimported extension
			-- methods in completion lists. When committed, the appropriate using
			-- directive will be added at the top of the current file. This option can
			-- have a negative impact on initial completion responsiveness,
			-- particularly for the first few completion sessions after opening a
			-- solution.
			EnableImportCompletion = true,
			-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
			-- true
			AnalyzeOpenDocumentsOnly = false,
		},
		Sdk = {
			-- Specifies whether to include preview versions of the .NET SDK when
			-- determining which version to use for project loading.
			IncludePrereleases = false,
		},
	},
	root_dir = path,
}
