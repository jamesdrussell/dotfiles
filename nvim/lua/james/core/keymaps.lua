local keymap = vim.keymap

vim.g.mapleader = " "

keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>w", "<cmd>w<cr>")
keymap.set("n", "<leader>q", "<cmd>q<cr>")
keymap.set("n", "<leader>v", "<C-w>v")
keymap.set("n", "<leader>h", "<C-w>s")
keymap.set("n", "<leader>=", "<C-w>=")
keymap.set("n", "<leader>m", "<cmd>MaximizerToggle<cr>")
keymap.set("n", "<leader>x", "<cmd>close<cr>")

keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>s", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>e", "<cmd>Telescope file_browser<cr>")
keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>l", "<cmd>Telescope current_buffer_fuzzy_find<cr>")

keymap.set("n", "<leader>t", "<cmd>ToggleTerm direction=float<cr>")
keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>c")
keymap.set("t", "<Esc>", "<C-\\><C-n><C-w>c")
keymap.set("n", "<leader>g", "<cmd>lua _LAZYGIT_TOGGLE()<cr>")

keymap.set("n", "H", "^")
keymap.set("n", "L", "$")
keymap.set("n", "J", "5j")
keymap.set("n", "K", "5k")

keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-j>", "<Down>")
keymap.set("i", "<C-k>", "<Up>")
keymap.set("i", "<C-l>", "<Right>")
