return {
    "nvim-telescope/telescope.nvim",
    --tag = "0.1.6",
    branch = "0.1.x",
    config = function()
        local telescope = require("telescope")
        local telescope_builtin = require("telescope.builtin")
        telescope.setup({ hidden = true })
        telescope.load_extension("harpoon")
        vim.keymap.set("n", "<leader>tf", "<cmd>Telescope find_files hidden=true<CR>")
        vim.keymap.set("n", "<leader>tg", "<cmd>Telescope live_grep hidden=true<CR>")
        vim.keymap.set("n", "<leader>tb", "<cmd>Telescope buffers<CR>")
    end,
    dependencies = {
        { "nvim-lua/plenary.nvim" },
    },
}
