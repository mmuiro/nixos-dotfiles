return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        require('nvim-tree').setup({
            git = {
                ignore = false,
            },
        })
        local nvim_tree_api = require("nvim-tree.api")
        vim.keymap.set('n', '<C-f>', nvim_tree_api.tree.toggle)
    end,
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
    },
}
