return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
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
                    follow_current_file = {
                        enabled = true
                    }
                },
                enable_git_status = true,
                default_component_configs = {
                    git_status = {
                        symbols = {
                            untracked = "",
                            ignored   = "",
                            unstaged  = "",
                            staged    = "",
                            conflict  = ""
                        }
                    }
                }
            })
        end,
        enabled = true
    },
    {
        "MunifTanjim/nui.nvim",
        lazy = true,
        enabled = true
    }
}
