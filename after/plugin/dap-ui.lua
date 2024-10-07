require("dapui").setup()

vim.keymap.set("n", "<leader>dt", ":lua require('dapui').toggle()<CR>")
vim.keymap.set("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<leader>8", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<leader>9", ":lua require'dap'.step_into()<CR>")
