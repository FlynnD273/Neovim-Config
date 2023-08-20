vim.api.nvim_create_user_command('SoSync', 'w | so | PackerSync', {})
local script_dir = debug.getinfo(1, "S").source:sub(2):match("(.*/)")

vim.cmd(string.format([[
   autocmd BufNewFile *.sh silent! 0r %s/../../templates/bash.sh
]], script_dir))
