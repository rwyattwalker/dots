-- KEYBINDINGS
-------------------------------------------------

local function map(m, k, v)
   vim.keymap.set(m, k, v, { silent = true })
end

-- Mimic shell movements
map('i', '<C-E>', '<ESC>A')
map('i', '<C-A>', '<ESC>I')

-- Load recent sessions
map('n', '<leader>sl', '<CMD>SessionLoad<CR>')

-- Keybindings for telescope
map('n', '<leader>fr', '<CMD>Telescope oldfiles<CR>')
map('n', '<leader>ff', '<CMD>Telescope find_files<CR>')
map('n', '<leader>fb', '<CMD>Telescope file_browser<CR>')
map('n', '<leader>fw', '<CMD>Telescope live_grep<CR>')
map('n', '<leader>ht', '<CMD>Telescope colorscheme<CR>')

--Keybindings for NeoTree
map('n', '<leader>tt', '<CMD>Neotree<CR>')

--Keybindings for Buffer 
-- Navigate buffers
map('n', '<leader>ll',"<CMD>bnext<CR>")
map('n', '<leader>hh',"<CMD>bprevious<CR>")
-- Delete Buffer
map('n', '<leader>--', "<CMD>Bdelete<CR>")
--Toggle terminal
map('n', '<leader>tf',"<CMD>ToggleTerm direction=float<CR>")
map('n', '<leader>th',"<CMD>ToggleTerm direction=horizontal<CR>")
map('n', '<leader>2th',"<CMD>2 ToggleTerm direction=horizontal<CR>")
map('n', '<leader>3th',"<CMD>3 ToggleTerm direction=horizontal<CR>")
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

