-- local cmd = { vim.env.HOME .. '/jdtls/bin/jdtls' }
-- if vim.is_windows then
--   cmd = { vim.env.HOME .. '/.vscode/extensions/redhat.java-1.35.1-win32-x64/server/bin/jdtls.bat' }
-- end
-- local config = {
--   cmd = cmd,
--   root_dir = vim.fs.dirname(vim.fs.find({ '.idea', 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
-- }
-- require('jdtls').start_or_attach(config)
