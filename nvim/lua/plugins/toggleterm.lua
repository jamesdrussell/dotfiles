return {
    "akinsho/toggleterm.nvim",
    keys = {
        {"<leader>t", function()
            require("toggleterm.terminal").Terminal:new({
                count = 0,
                on_open = function(term)
                    vim.keymap.set("t", "<Esc>", "<C-\\><C-n><C-w>c", {noremap = true, silent = true, buffer = term.bufnr})
                end
            }):toggle()
        end},
        {"<leader>g", function()
            require("toggleterm.terminal").Terminal:new({
                cmd = "lazygit",
                count = 1
            }):toggle()
        end}
    },
    config = function()
        require("toggleterm").setup({
            direction = "float",
            hidden = true
        })
    end,
    enabled = false
}
