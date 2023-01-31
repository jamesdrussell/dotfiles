local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
    return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
    return
end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            }
        }
    },
    extensions = {
        file_browser = {
            hijack_netrw = true,
            mappings = {
                i = {
                    ["<C-e>"] = fb_actions.create,
                },
                n = {
                    e = fb_actions.create,
                }
            }
        }
    }
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")
