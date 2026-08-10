-- Set Space as Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Quick exit from Insert Mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit Insert Mode" })

-- Clear search highlights easily
vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Better window navigation (use Ctrl + h/j/k/l instead of Ctrl-w + direction)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
