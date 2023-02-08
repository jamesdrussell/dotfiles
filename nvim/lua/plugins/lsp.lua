return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "rust_analyzer"
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lspconfig")["rust_analyzer"].setup({
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                on_attach = function(client, bufnr)
                    local opts = { noremap = true, silent = true, buffer = bufnr }

                    vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
                    vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
                    vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
                    vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
                    vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
                    vim.keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
                    vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
                    vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
                    vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
                    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
                    vim.keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)
                end,
                settings = {
                    ["rust-analyzer"] = {}
                }
            })
        end
    },
    {
        "hrsh7th/cmp-nvim-lsp"
    },
    {
        "glepnir/lspsaga.nvim",
        branch = "main"
    }
}