return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local builtin = require("telescope.builtin")
    -- Bind Telescope searches to Space + f + f (files) and Space + f + g (grep)
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find Text in Project" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Open Buffers" })
  end,
}
