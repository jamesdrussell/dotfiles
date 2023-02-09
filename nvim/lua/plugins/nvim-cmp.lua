return {
    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("luasnip/loaders/from_vscode").lazy_load()

            vim.opt.completeopt = "menu,menuone,noselect"

            require("cmp").setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                mapping = require("cmp").mapping.preset.insert({
                    ["<C-k>"] = require("cmp").mapping.select_prev_item(),
                    ["<C-j>"] = require("cmp").mapping.select_next_item(),
                    ["<C-b>"] = require("cmp").mapping.scroll_docs(-4),
                    ["<C-f>"] = require("cmp").mapping.scroll_docs(4),
                    ["<C-Space>"] = require("cmp").mapping.complete(),
                    ["<C-e>"] = require("cmp").mapping.abort(),
                    ["<CR>"] = require("cmp").mapping.confirm({ select = false })
                }),
                sources = require("cmp").config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" }
                }),
                formatting = {
                    format = require("lspkind").cmp_format({
                        maxwidth = 50,
                        ellipsis_char = "..."
                    }),
                },
            })
        end,
        enabled = true
    },
    {
        "L3MON4D3/LuaSnip",
        enabled = true
    },
    {
        "onsails/lspkind.nvim",
        enabled = true
    },
    {
        "hrsh7th/cmp-buffer",
        enabled = true
    },
    {
        "hrsh7th/cmp-path",
        enabled = true
    },
    {
        "saadparwaiz1/cmp_luasnip",
        enabled = true
    },
    {
        "rafamadriz/friendly-snippets",
        enabled = true
    }
}
