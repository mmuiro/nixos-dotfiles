return {
    "folke/which-key.nvim",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
        require("which-key").setup({
            window = {
                border = "single",
                winblend = 5,
            }
        })
    end,
}
