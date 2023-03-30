return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        keys = {
            {"<leader>e", function()
                require("neo-tree.command").execute({
                    action = "focus",
                    toggle = true,
                    reveal = true
                })
            end},
        },
        config = function()
            require("neo-tree").setup({
                close_if_last_window = true,
                filesystem = {
                    follow_current_file = true
                }
            })
        end,
        enabled = false
    },
    {
        "MunifTanjim/nui.nvim",
        lazy = true,
        enabled = true
    }
}
