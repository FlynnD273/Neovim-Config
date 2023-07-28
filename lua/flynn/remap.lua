vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("i", "<S-Tab>", "<C-d>")
vim.keymap.set("n", "ca", 'gg0VG"+y')

vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")

vim.keymap.set("n", "<leader>fh", vim.cmd.foldclose)
vim.keymap.set("n", "<leader>fl", vim.cmd.foldopen)

vim.keymap.set("n", "<C-w>o", ":tabe %<CR>")
vim.keymap.set("n", "<C-w>i", ":q<CR>")

vim.keymap.set("n", "<leader>dt", function() require("dapui").toggle() end, { noremap = true })
vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true })
vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>", { noremap = true })
vim.keymap.set("n", "<leader>do", ":DapStepOver<CR>", { noremap = true })
vim.keymap.set("n", "<leader>dO", ":DapStepOut<CR>", { noremap = true })
vim.keymap.set("n", "<leader>di", ":DapStepInto<CR>", { noremap = true })
