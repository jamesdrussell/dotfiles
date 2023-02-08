return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup({
            highlight = {
                enable = true,
            },
            indent = { enable = true },
            autotag = { enable = true },
            ensure_installed = {
                "rust",
                "vim",
                "lua",
            },
            auto_install = true
        })
    end,
    run = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end
}