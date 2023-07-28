local c_moonfly = require'lualine.themes.moonfly'

-- Apparently Moonfly doesn't create a command property by default
c_moonfly.command = { a = { bg = '', fg = '' } }

c_moonfly.normal.a.bg = '#000000'
c_moonfly.insert.a.bg = '#000000'
c_moonfly.visual.a.bg = '#000000'
c_moonfly.command.a.bg = '#000000'
c_moonfly.replace.a.bg = '#000000'
c_moonfly.inactive.a.bg = '#000000'

c_moonfly.normal.a.fg = '#bfcffc'
c_moonfly.insert.a.fg = '#fcfcfc'
c_moonfly.visual.a.fg = '#ecbffc'
c_moonfly.command.a.fg = '#fcebbf'
c_moonfly.replace.a.fg = '#fcbfd3'
c_moonfly.inactive.a.fg = '#7f7f7f'

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = c_moonfly,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
