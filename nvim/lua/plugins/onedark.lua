return {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("onedark").setup({
            style = "light"
        })

        require("onedark").load()
    end,
    enabled = true
}

