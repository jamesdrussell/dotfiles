return {
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        lazy = true,
        enabled = true
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        keys = {
            {"<leader>f", function()
                require("telescope.builtin").find_files()
            end},
            {"<leader>s", function()
                require("telescope.builtin").live_grep()
            end},
            {"<leader>b", function()
                require("telescope.builtin").buffers()
            end},
            {"<leader>l", function()
                require("telescope.builtin").current_buffer_fuzzy_find()
            end}
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-k>"] = require("telescope.actions").move_selection_previous,
                            ["<C-j>"] = require("telescope.actions").move_selection_next,
                            ["<Esc>"] = require("telescope.actions").close
                        }
                    },
                    preview = false
                },
                pickers = {
                    find_files = {
                        theme = "dropdown",
                        hidden = false
                    },
                    live_grep = {
                        theme = "dropdown"
                    },
                    buffers = {
                        theme = "dropdown"
                    },
                    current_buffer_fuzzy_find = {
                        theme = "dropdown"
                    }
                }
            })

            require("telescope").load_extension("fzf")
        end,
        enabled = true
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    file_browser = {
                        hijack_netrw = true,
                        mappings = {
                            i = {
                                ["<C-e>"] = require("telescope").extensions.file_browser.actions.create,
                            },
                            n = {
                                e = require("telescope").extensions.file_browser.actions.create,
                            }
                        },
                        theme = "dropdown"
                    }
                }
            })

            require("telescope").load_extension("file_browser")
        end,
        keys = {
            {"<leader>e", function()
                require("telescope").extensions.file_browser.file_browser()
            end},
        },
        enabled = true
    }
}
