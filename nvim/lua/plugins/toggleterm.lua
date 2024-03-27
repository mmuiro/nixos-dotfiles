
return {
    "akinsho/toggleterm.nvim",
    version = '*',
    config = function()
        require("toggleterm").setup({
            open_mapping = [[<C-\>]],
            direction = "float",
            float_opts = {
                border = "curved",
                winblend = 20,
            }
        })
    end,
}
