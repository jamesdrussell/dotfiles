return {
    "pbrisbin/vim-colors-off",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme off]])
    end,
    enabled = true
}

