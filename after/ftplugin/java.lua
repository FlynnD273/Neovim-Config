local cmd = { '~/jdtls/bin/jdtls' }
if vim.is_windows then
  cmd = { '~/vin/jdtls' }
end
local config = {
  cmd = cmd,
  root_dir = vim.fs.dirname(vim.fs.find({ '.idea', 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)
