return {
    "joshdick/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme onedark]])
    end,
    enabled = true
}

