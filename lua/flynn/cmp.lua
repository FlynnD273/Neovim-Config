local cmp = require 'cmp'
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
    { name = 'nvim_lsp_signature_help' },
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
        globals = { 'vim', 'require', 'use_rocks' },
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
require('lspconfig').csharp_ls.setup {
  capabilities = capabilities,
  root_dir = function(startpath)
    local lspconfig = require('lspconfig')
    return lspconfig.util.root_pattern("*.sln")(startpath)
        or lspconfig.util.root_pattern("*.csproj")(startpath)
        or lspconfig.util.root_pattern("*.fsproj")(startpath)
        or lspconfig.util.root_pattern(".git")(startpath)
  end,
}
require('lspconfig').pyright.setup {
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true
      }
    }
  }
}
require('lspconfig').gdscript.setup { capabilities = capabilities }
require('lspconfig').html.setup { capabilities = capabilities }
require('lspconfig').rust_analyzer.setup { capabilities = capabilities }
require('lspconfig').ts_ls.setup { capabilities = capabilities }
require 'lspconfig'.ccls.setup { capabilities = capabilities }
require 'lspconfig'.texlab.setup { capabilities = capabilities }
require 'lspconfig'.bashls.setup { capabilities = capabilities }
require 'lspconfig'.sqlls.setup { capabilities = capabilities }
-- require'lspconfig'.java_language_server.setup {
-- 	capabilities = capabilities,
-- 	cmd = { "bash", "/home/flynn/Documents/misc-git/java-language-server/dist/lang_server_linux.sh" },
-- }
require 'lspconfig'.cssls.setup { capabilities = capabilities }
require 'lspconfig'.jsonls.setup { capabilities = capabilities }
require 'lspconfig'.racket_langserver.setup { capabilities = capabilities }
require 'lspconfig'.glslls.setup { capabilities = capabilities }

if vim.loop.os_uname().sysname == "Windows_NT" then
  local home = vim.env.HOME
  if home == nil then
    home = os.getenv("HOME")
  end
  require 'lspconfig'.powershell_es.setup { -- https://github.com/PowerShell/PowerShellEditorServices/releases
    bundle_path = home .. [[/PowerShellEditorServices]],
  }
end




--[[
comes with Godot
cargo install texlab
dotnet tool install --global csharp-ls
raco pkg install racket-langserver
rustup component add rust-analyzer
sudo npm i -g bash-language-server
sudo npm i -g pyright
sudo npm i -g sql-language-server
sudo npm i -g typescript-language-server typescript
sudo npm i -g vscode-langservers-extracted
sudo pacman -S ccls
echo ;Install GLSLLS from https://github.com/svenstaro/glsl-language-server'

python -m venv ~/.local/venv/nvim/
~/.local/venv/nvim/bin/pip install pynvim black gdtoolkit==4.*

https://github.com/georgewfraser/java-language-server

WINDOWS
cd
python -m venv ./venv/nvim/
~\venv\nvim\Scripts\pip.exe install pynvim black gdtoolkit==4.*

]]
