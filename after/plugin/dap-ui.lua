require("dapui").setup()

vim.keymap.set("n", "<leader>dt", function() require("dapui").toggle() end, { noremap = true })
vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", { noremap = true })
vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>", { noremap = true })
vim.keymap.set("n", "<leader>do", ":DapStepOver<CR>", { noremap = true })
vim.keymap.set("n", "<leader>dO", ":DapStepOut<CR>", { noremap = true })
vim.keymap.set("n", "<leader>di", ":DapStepInto<CR>", { noremap = true })
