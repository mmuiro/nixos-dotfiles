return {
    "folke/noice.nvim",
    enabled = false,
    config = function()
        require("noice").setup()
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify",
            config = function()
                require("notify").setup({
                    background_colour = "#262A2A"
                })
            end
        },
    },
}
