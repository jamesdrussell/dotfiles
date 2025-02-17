return {
    {
        "NeogitOrg/neogit",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("neogit").setup({
                disable_hint = true,
                kind = "floating"
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
