-- autopairs
-- https://github.com/windwp/nvim-autopairs

vim.pack.add { 'https://github.com/folke/snacks.nvim' }
require('snacks').setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bufdelete = {enabled = true},
    -- bigfile = { enabled = true },
    -- dashboard = { enabled = true },
    -- explorer = { enabled = true },
    -- indent = { enabled = true },
    -- input = { enabled = true },
    -- picker = { enabled = true },
    -- notifier = { enabled = true },
    -- quickfile = { enabled = true },
    -- scope = { enabled = true },
    -- scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
}
-- Delete current buffer
vim.keymap.set("n", "<leader>x", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })

-- Force delete current buffer
vim.keymap.set("n", "<leader>bD", function() Snacks.bufdelete.delete() end, { desc = "Force Delete Buffer" })

-- Delete all other buffers except the current one
vim.keymap.set("n", "<leader>bx", function() Snacks.bufdelete.other() end, { desc = "Delete Other Buffers" })
