-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    Format_func = function() end
    local local_format = function() end
    if vim.bo.filetype == "python" then
      local_format = function()
        vim.cmd([[python << EOF
import black
mode = black.FileMode()
try:
  vim.current.buffer[:] = black.format_file_contents("\n".join(vim.current.buffer[:]), fast= False, mode= mode).split("\n")
except black.parsing.InvalidInput as e:
  pass
  # print("Couldn't format file, invalid syntax\n")
except black.report.NothingChanged:
  pass
EOF]])
      end
    elseif vim.bo.filetype == "gdscript" then
      local_format = function()
        vim.cmd([[python << EOF
from gdtoolkit.formatter.__main__ import _format_code
success, actually_formatted, formatted_code = _format_code("\n".join(vim.current.buffer[:]), 88, 2, "STDIN", True)
if success:
  vim.current.buffer[:] = formatted_code.split("\n")
else:
  pass
  # print("Couldn't format file, invalid syntax\n")
EOF]])
      end
    else
      local_format = function()
        vim.lsp.buf.format { async = false }
      end
    end
    Format_func = function()
      if (Autoformat == nil or Autoformat) then
        local_format()
      end
    end
    vim.keymap.set('n', '<leader>rf', local_format, opts)
  end,
})
