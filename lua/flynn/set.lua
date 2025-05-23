local home = vim.env.HOME
if home == nil then
  home = os.getenv("HOME")
end
vim.env.HOME = home

if vim.is_windows then
  vim.g.python3_host_prog = home .. '/venv/nvim/Scripts/python.exe'
  vim.opt.shell = 'pwsh'
  vim.opt.shellcmdflag = '-Command'
  vim.g.undotree_DiffCommand = "pwsh -Command Compare-Object"
else
  vim.g.python3_host_prog = home .. '/.local/venv/nvim/bin/python'
end

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.expandtab = false

vim.opt.autoread = true
vim.opt.signcolumn = "yes"

vim.g.moonflyItalics = false
vim.g.moonflyCursorColor = false
vim.g.moonflyCUndercurls = false
vim.g.moonflyVirtualTextColor = true
vim.cmd.colorscheme("moonfly")

vim.opt.undodir = home .. "/.vim/undo"
vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.foldmethod = "marker"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.foldlevel = 5

vim.opt.scrolloff = 5
-- vim.cmd("set foldenable")

-- local unfoldall = vim.api.nvim_create_augroup('unfoldall', {clear = true})
-- vim.api.nvim_create_autocmd({"FileReadPost"}, {
--   group = "unfoldall",
--   callback = function()
--       vim.api.nvim_input('zR')
--   end,
-- })

-- vim.g.indent_guides_auto_colors = 0
-- vim.cmd.hi("IndentGuidesOdd guibg='#111111'")
-- vim.cmd.hi("IndentGuidesEven guibg='#212121'")
-- vim.g.python_highlight_all = 1
-- vim.g.indent_guides_enable_on_vim_startup = 1

local function before_save()
  -- Check if LSP is attached
  local buf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = buf })
  if #clients > 0 then
    Format_func()
  end
end

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = before_save,
})
