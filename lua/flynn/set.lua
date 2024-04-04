vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.linebreak = true
vim.opt.breakindent = true

vim.g.moonflyItalics = false
vim.g.moonflyCursorColor = false
vim.g.moonflyCUndercurls = false
vim.g.moonflyVirtualTextColor = true
vim.cmd.colorscheme("moonfly")

home = io.popen("cd"):read()
if home == nil then
	home = os.getenv("HOME")
end
vim.opt.undodir = home .. "/.vim/undo"
vim.opt.undofile = true

-- vim.opt.foldmethod = "expr"
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
