vim.api.nvim_create_user_command('SoSync', 'w | so | PackerSync', {})
local script_dir = debug.getinfo(1, "S").source:sub(2):match("(.*/)")

vim.cmd(string.format([[
   autocmd BufNewFile *.sh silent! 0r %s/../../templates/bash.sh
]], script_dir))

-- function Execute_command(command)
--     local tmpfile = os.tmpname()
--     local exit = os.execute(command .. ' > ' .. tmpfile .. ' 2> ' .. tmpfile .. '.err')

--     local stdout_file = io.open(tmpfile)
--     local stdout = stdout_file:read("*all")

--     local stderr_file = io.open(tmpfile .. '.err')
--     local stderr = stderr_file:read("*all")

--     stdout_file:close()
--     stderr_file:close()

--     return exit, stdout, stderr
-- end

-- function Compile_tex()
-- 	local tex_file = vim.fn.expand('%:p') -- Get the full path of the current file
-- 	local dir = ""
-- 	if package.config:sub(1, 1) == '\\' then
-- 			dir = tex_file:match("(.*\\)")
-- 	else
-- 			dir = tex_file:match("(.*/)")
-- 	end

-- 	local cmd =  'pdflatex -interaction=nonstopmode "' .. tex_file .. '"' .. ' -output-directory="' .. dir .. '"'
-- 	print(cmd)
-- 	local exit_code, stdout, stderr = Execute_command(cmd)

-- 	if exit_code ~= 0 then
-- 		print(stdout)
-- 	end
-- end

-- -- Set up an autocommand to trigger the compile_tex function on BufWritePost for .tex files
-- vim.cmd([[
--     augroup latex_compile
--         autocmd!
--         autocmd BufWritePost *.tex lua Compile_tex()
--     augroup END
-- ]])
