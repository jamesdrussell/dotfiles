return {
    "akinsho/toggleterm.nvim",
    keys = {
        {"<leader>t", function()
            require("toggleterm.terminal").Terminal:new({count = 0}):toggle()
        end},
        {"<leader>g", function()
            require("toggleterm.terminal").Terminal:new({cmd = "lazygit", count = 1}):toggle()
        end}
    },
    config = function()
        require("toggleterm").setup({
            direction = "float",
            hidden = true
        })
    end
}
