return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup()
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- diagnostics window setup
            vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
            vim.opt.shortmess = vim.opt.shortmess + "c"
            local sign = function(opts)
                vim.fn.sign_define(opts.name, {
                    texthl = opts.name,
                    text = opts.text,
                    numhl = ""
                })
            end

            sign({ name = "DiagnosticSignError", text = "󰅚 " })
            sign({ name = "DiagnosticSignWarn", text = " " })
            sign({ name = "DiagnosticSignHint", text = "󰌶" })
            sign({ name = "DiagnosticSignInfo", text = " " })

            vim.diagnostic.config({
                virtual_text = false,
                signs = true,
                update_in_insert = true,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
            })

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = "rounded",
            })

            -- setup individual lsp servers
            -- keybindings
            local lsp_on_attach = function(_, bufnr)
                local opts = { noremap = true, silent = true }
                local keymap = vim.api.nvim_buf_set_keymap
                keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
                keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
                keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
                keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
                keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
                keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
                keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
                keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
                keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
                keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
                keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
                keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
                keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
                keymap(bufnr, "n", "<leader>ln", "<cmd>Navbuddy<CR>", opts)
            end

            require("lspconfig")["pyright"].setup({
                on_attach = function(_, bufnr)
                    vim.g.python_indent = {
                        open_paren = "shiftwidth()",
                        continue = "shiftwidth()",
                        closed_paren_align_last_line = false,
                    }
                    lsp_on_attach(_, bufnr)
                end
            })

            require("lspconfig")["gopls"].setup({
                on_attach = lsp_on_attach,
            })

            require("lspconfig")["lua_ls"].setup({
                on_attach = lsp_on_attach,
            })

            require("lspconfig")["cssls"].setup({
                on_attach = lsp_on_attach,
            })

            require("lspconfig")["jdtls"].setup({
                on_attach = lsp_on_attach,
            })

            require("lspconfig")["html"].setup({
                on_attach = lsp_on_attach,
            })

            require("rust-tools").setup({
                server = {
                    on_attach = lsp_on_attach,
                },
            })

            require("clangd_extensions").setup({
                server = {
                    on_attach = lsp_on_attach
                }
            })
        end,
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "simrat39/rust-tools.nvim",
            "p00f/clangd_extensions.nvim",
            {
                "SmiteshP/nvim-navbuddy",
                dependencies = {
                    "SmiteshP/nvim-navic",
                    "MunifTanjim/nui.nvim"
                },
                opts = {
                    window = { border = "rounded" },
                    lsp = { auto_attach = true },
                }
            }
        },
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            -- cmp setup
            local kind_icons = {
                Text = "󰉿",
                Method = "m",
                Function = "󰊕",
                Constructor = "",
                Field = "",
                Variable = "󰆧",
                Class = "󰌗",
                Interface = " ",
                Module = "",
                Property = "",
                Unit = "",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰇽",
                Struct = " ",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰊄",
            }
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = {
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<down>"] = cmp.mapping.select_next_item(),
                    ["<up>"] = cmp.mapping.select_prev_item(),
                    ["<C-F>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "vsnip" },
                    { name = "path" },
                    { name = "buffer" },
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, item)
                        item.kind = string.format("%s", kind_icons[item.kind])
                        local menu_icons = {
                            nvim_lsp = "[LSP]",
                            vsnip = "[Snip]",
                            buffer = "[Buf]",
                            path = "[Path]",
                        }
                        item.menu = menu_icons[entry.source.name]
                        return item
                    end,
                }
            })
        end,
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-vsnip" },
            { "hrsh7th/vim-vsnip" },
        }
    },
}
