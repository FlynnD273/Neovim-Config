require("mason").setup()
require("mason-lspconfig").setup()
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
require("mason-lspconfig").setup_handlers {
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup { capabilities = capabilities, }
  end,

  -- ["omnisharp"] = function()
  --   lspconfig.omnisharp.setup {
  --   }
  -- end
}
