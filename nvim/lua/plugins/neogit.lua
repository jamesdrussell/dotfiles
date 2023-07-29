return {
    {
        "NeogitOrg/neogit",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("neogit").setup({
                kind = "replace"
            })
        end,
        keys = {
            {"<leader>g", function()
                require("neogit").open()
            end}
        },
        enabled = true
    }
}
