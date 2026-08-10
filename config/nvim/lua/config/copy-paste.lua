-- 1. Sync Neovim's default register with the '+' (system) register
vim.opt.clipboard = "unnamedplus"

-- 2. Direct all '+' register yanks through OSC 52 to your host clipboard
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

-- 3. (Optional) Make capital 'Y' copy from cursor to end of line (standard Neovim default)
vim.keymap.set('n', 'Y', 'y$')

