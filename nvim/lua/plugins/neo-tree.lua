return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
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
