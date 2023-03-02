return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        keys = {
            {"<leader>e", function()
                require("neo-tree").focus()
            end},
        },
        config = function()
            require("neo-tree").setup()
        end,
        enabled = true
    },
    {
        "MunifTanjim/nui.nvim",
        enabled = true
    }
}
