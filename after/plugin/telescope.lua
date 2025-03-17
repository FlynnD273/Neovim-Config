local telescope = require('telescope')
-- telescope.setup {
--   extensions = {
--     live_grep_args = {
--       auto_quoting = true,
--     }
--   }
-- }
telescope.load_extension('fzf')
telescope.load_extension("live_grep_args")
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [f]iles]' })
vim.keymap.set('n', '<leader>fp', builtin.git_files, { desc = '[F]ind git [p]roject files' })
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind [g]rep' })
vim.keymap.set('n', '<leader>fg', telescope.extensions.live_grep_args.live_grep_args, { desc = '[F]ind [g]rep' })
-- vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
