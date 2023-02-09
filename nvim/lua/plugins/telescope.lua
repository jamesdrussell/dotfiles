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
                            ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
                            ["<C-w>"] = require("telescope.actions").close,
                            ["<Esc>"] = require("telescope.actions").close
                        }
                    },
                    layout_strategy = "vertical",
                    layout_config = {
                        prompt_position = "top",
                    },
                    preview = false,
                    sorting_strategy = "ascending"
                },
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
                        }
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
