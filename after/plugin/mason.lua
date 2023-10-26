local servers = {
	"clangd",
	"csharp_ls",
	"cssls",
	"html",
	"jsonls",
	"ltex",
	"lua_ls",
	"powershell_es",
	"pyright",
	"tsserver",
}

require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = servers,
	automatic_installation = true,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
for _, v in pairs(servers) do
	require('lspconfig')[v].setup { capabilities = capabilities }
end

