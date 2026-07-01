-- For conciseness
local opts = { noremap = true, silent = true }

vim.keymap.set('n', 'cp', ':let @" = expand("%")', { desc = 'Copy file path to unamed register' })
vim.keymap.set('n', ';;', ':%s///g<Left><Left><Left>', { desc = 'quick command line substitution in normal mode' })
vim.keymap.set('v', ';;', ':s///g<Left><Left><Left>', { desc = 'quick command line substitution in visual mode' })
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Leave terminal' })
vim.keymap.set('t', '<C-Left>', '<C-\\><C-n><C-w>h', { desc = 'Leave terminal' })
vim.keymap.set('n', '<C-Right>', '<C-w>li', { desc = 'When entering with comtrol-right enter insert mode. Workaround for terminals' })
-- vim.keymap.set('n', '<F5>', ':72 vs <bar> term ipython<Enter>', { desc = 'open terminal in a split' })
-- vim.keymap.set('n', '<F6>', '<C-w><C-l>G<C-w><C-h>', { desc = 'open terminal in a split' })
-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>x', ':bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

vim.keymap.set('n', '<leader><Enter>', function()
  local buf_id
  for channel_index, channel_entry in ipairs(vim.api.nvim_list_chans()) do
    if channel_entry['mode'] == 'terminal' then
      buf_id = channel_entry['id']
    end
  end

  local control_J = vim.api.nvim_replace_termcodes('<C-J>', true, true, true)
  local control_Q = vim.api.nvim_replace_termcodes('<C-Q>', true, true, true)
  -- print(vim.inspect(line))
  local start_cell = vim.fn.search('#---', 'Wb')
  local end_cell = vim.fn.search('#---', 'W')
  if end_cell == 0 then
    end_cell = vim.fn.line '$'
  end

  local input_lines = vim.fn.getline(start_cell, end_cell)
  -- vim.fn.chansend(buf_id, "%%capture --no-stdout" .. "\n")
  for line_index, line in ipairs(input_lines) do
    if line ~= '' and vim.fn.match(line, '#---') == -1 then
      vim.fn.chansend(buf_id, line .. control_Q .. control_J)
    end
  end
  vim.fn.chansend(buf_id, control_J)
end)

-- vim.keymap.set('n', '-', function()
--   require('neo-tree.command').execute {
--     action = 'focus', -- OPTIONAL, this is the default value
--     source = 'filesystem', -- OPTIONAL, this is the default value
--     position = 'left', -- OPTIONAL, this is the default value
--     toggle = true,
--     reveal = false,
--     -- reveal_file = reveal_file, -- path to file or folder to reveal
--     -- reveal_force_cwd = true, -- change cwd without asking if needed
--   }
-- end, { desc = 'Open neo-tree at current file or working directory' })

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*',
  command = [[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]],
  desc = 'return to last cursor position when reopening the file',
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'python',
  command = [[iabbrev <buffer> pf print(f'<C-v>{ = <C-v>}'<esc>F{a]],
  desc = 'expand formated print',
})
vim.api.nvim_create_autocmd({ 'BufLeave' }, {
  pattern = '*.py',
  command = [[:w | normal m"]],
  desc = 'save python files when leaving the buffer',
})

-- vim.api.nvim_create_autocmd({ 'BufLeave' }, {
--   pattern = '*',
--   -- command = [[:normal mp]],
--   desc = 'save marker',
--   callback = function(ev)
--     print(string.format('event fired: %s', vim.inspect(ev)))
--   end,
-- })

vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  pattern = '*',
  command = [[:startinsert!]],
  desc = 'Insert mode when entering terminal',
  --  nested = true,
  --  callback = function(ev)
  --    print(string.format('event fired: %s', vim.inspect(ev)))
  --  end,
})
