local keymap = vim.keymap

vim.g.mapleader = " "

keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>se", "<C-w>=")
keymap.set("n", "<leader>sx", ":close<CR>")

keymap.set("n", "<leader>to", ":tabnew<CR>")
keymap.set("n", "<leader>tx", ":tabclose<CR>")
keymap.set("n", "<leader>tn", ":tabn<CR>")
keymap.set("n", "<leader>tp", ":tabp<CR>")

keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>e", "<cmd>Telescope file_browser<cr>")
keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>")

keymap.set("n", "H", "^")
keymap.set("n", "L", "$")
keymap.set("n", "J", "5j")
keymap.set("n", "K", "5k")

keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-j>", "<Down>")
keymap.set("i", "<C-k>", "<Up>")
keymap.set("i", "<C-l>", "<Right>")
