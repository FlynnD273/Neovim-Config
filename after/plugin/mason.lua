require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = {
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
	},
}
