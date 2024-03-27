-- disabled

return {
    "gelguy/wilder.nvim",
    enabled = false,
    config = function()
        local wilder = require('wilder')
        wilder.setup({
            modes = {},
            next_key = { "<C-n>", "<Tab>" },
            prev_key = { "<C-p>", "<S-Tab>" },
        })

        wilder.set_option('renderer', wilder.popupmenu_renderer(
            wilder.popupmenu_border_theme({
                highlighter = wilder.basic_highlighter(),
                pumblend = 5,
                highlights = {
                    border = "FloatBorder",
                },
                border = "rounded",
            })
        ))
    end,
}
