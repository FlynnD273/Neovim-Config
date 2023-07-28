local dap = require('dap')

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
			local path = vim.api.nvim_buf_get_name(0)
			local lfs = require"lfs"

			local function getfolder(p, sep)
				p = p:match(".*"..sep)
				return p:sub(0, p:len() - 1)
			end

			local linux = path:match(".*/")
			local windows = path:match(".*\\")

			local sep = "/"

			if windows then
				path = windows
				sep = "\\"
			elseif linux then
				path = linux
			end

			local currdir = getfolder(path, sep)
			local projpath = nil

			while not projpath do
				for file in lfs.dir(currdir) do
					if file ~= "." and file ~= ".." then
						if file:match("%.csproj$") then
							projpath = currdir..sep..file
							break
						end
					end
				end
				currdir = getfolder(currdir, sep)
			end

			local projname = projpath:sub(getfolder(projpath, sep):len() + 2, projpath:len() - 7)
			projpath = getfolder(projpath, sep)

			local function find(dir, pattern)
				local dirs = {}
				for file in lfs.dir(dir) do
					if file ~= "." and file ~= ".." then
						local f = dir..sep..file
						if file:match(pattern) then
							return f
						end
						local attr = lfs.attributes(f)
						if attr.mode == "directory" then
							table.insert(dirs, f)
						end
					end
				end
				if #dirs > 0 then
					for _, d in ipairs(dirs) do
						local found = find(d, pattern)
						if found then
							return found
						end
					end
				end
			end

			local dllpath = find(projpath..sep.."bin", projname..".dll")

			return vim.fn.input('Path to dll: ', dllpath, 'file')
    end,
  },
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = {
	{
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    initCommands = function()
      -- Find out where to look for the pretty printer Python module
      local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

      local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
      local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

      local commands = {}
      local file = io.open(commands_file, 'r')
      if file then
        for line in file:lines() do
          table.insert(commands, line)
        end
        file:close()
      end
      table.insert(commands, 1, script_import)

      return commands
    end,
  }
}

dap.configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
    launch_scene = true,
  }
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/home/flynn/anaconda3/bin/python'
      end
    end;
  },
}


