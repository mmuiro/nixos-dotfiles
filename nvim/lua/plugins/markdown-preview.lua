return {
    "iamcco/markdown-preview.nvim",
    config = function()
        vim.g.mkdp_filetypes = {"markdown"}
        vim.g.mkdp_theme = "dark"
    end,
    ft = "md",
}
