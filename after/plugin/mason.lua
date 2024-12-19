require("mason").setup()
require("mason-lspconfig").setup()
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
require("mason-lspconfig").setup_handlers {
  function(server_name)
    lspconfig[server_name].setup { capabilities = capabilities, }
  end,

  ["csharp_ls"] = function()
    local path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    local root_file = vim.fs.find({"*.sln", "*.csproj", "*.fsproj", ".git"}, { type = "file", path = path, upward = true })[1]
    path = vim.fs.dirname(root_file)
    lspconfig.csharp_ls.setup {
      capabilities = capabilities,
      root_dir = path,
    }
  end
}
