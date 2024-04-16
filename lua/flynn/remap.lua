vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("i", "<S-Tab>", "<C-d>")
vim.keymap.set("n", "<leader>ya", 'gg0VG"+y')

vim.keymap.set({ "v", "n" }, "H", "^")
vim.keymap.set({ "v", "n" }, "L", "$")

vim.keymap.set("n", "<leader>fh", vim.cmd.foldclose)
vim.keymap.set("n", "<leader>fl", vim.cmd.foldopen)

vim.keymap.set("n", "<C-w>o", ":tabe %<CR>")
vim.keymap.set("n", "<C-w>i", ":q<CR>")

vim.keymap.set({ "n", "v" }, ")", "")
vim.keymap.set({ "n", "v" }, "(", "")

vim.keymap.set("n", "<leader>j", ":cnext<CR>")
vim.keymap.set("n", "<leader>k", ":cprev<CR>")
