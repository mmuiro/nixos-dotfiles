return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        vim.cmd [[highlight IndentBlanklineIndentChar guifg=#313131 gui=nocombine]]
        require('ibl').setup({
            exclude = { filetypes = { "dashboard" } },
        })
    end,
}
