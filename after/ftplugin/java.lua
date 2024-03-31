local config = {
    cmd = {'/home/flynn/jdtls/bin/jdtls'},
    root_dir = vim.fs.dirname(vim.fs.find({'.idea', 'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)
