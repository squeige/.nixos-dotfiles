-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true  -- Relative line numbers make jump motions easy

-- Tabs & Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search Behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true       -- Case-sensitive only if search term contains uppercase

-- UI Quality-of-Life
vim.opt.termguicolors = true   -- True color support
vim.opt.scrolloff = 8          -- Keep 8 lines visible above/below cursor when scrolling
vim.opt.signcolumn = "yes"     -- Always display the sign column (prevents text jumping)
vim.opt.cursorline = true      -- Highlight current line
