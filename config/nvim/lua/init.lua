-- Load basic options and keymaps
require("config.options")
require("config.keymaps")
require("config.copy-paste")

-- Automatically install lazy.nvim if missing
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim and tell it to import everything in lua/plugins/
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
})

