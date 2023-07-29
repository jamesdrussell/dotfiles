return {
    {
        "NeogitOrg/neogit",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("neogit").setup()
        end,
        keys = {
            {"<leader>g", function()
                require("neogit").open({
                    kind = "replace"
                })
            end}
        },
        enabled = true
    }
}
