return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
        enabled = true
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local ensure_installed = {
                "rust_analyzer"
            }

            if not(require("jit").arch == "arm64" and require("jit").os == "Linux") then
                table.insert(ensure_installed, "lua_ls")
            end

            require("mason-lspconfig").setup({
                ensure_installed = ensure_installed
            })
        end,
        enabled = true
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local on_attach = function(_, bufnr)
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
                -- vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
                vim.keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)
            end

            require("lspconfig")["rust_analyzer"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    ["rust-analyzer"] = {}
                }
            })

            if not(require("jit").arch == "arm64" and require("jit").os == "Linux") then
                require("lspconfig")["lua_ls"].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }
                            }
                        }
                    }
                })
            end
        end,
        enabled = true
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        enabled = true
    },
    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require("lspsaga").setup({
                scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
                code_action_prompt = {
                    enable = false
                },
                lightbulb = {
                    enable = false
                },
                symbol_in_winbar = {
                    enable = false
                },
                definition = {
                    edit = "<CR>",
                },
                ui = {
                    colors = {
                        normal_bg = "#022746",
                    },
                },
            })
        end,
        enabled = true
    }
}
