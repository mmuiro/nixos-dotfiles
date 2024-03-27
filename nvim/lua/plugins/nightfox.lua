local limefrost = {
    bg0 = "#0E0F11",
    bg1 = "#131416",
    bg2 = "#25282D",
    bg3 = "#353A42",
    bg4 = "#535B68",
    sel0 = "#2C3035",
    sel1 = "#525A66",
    blue = { base = "#CEFFE2", bright = "#DCFFEA", dim = "#B9F2D0" },
    green = { base = "#ABF3BB", bright = "#A6FFC3", dim = "#9CEBAC" },
    magenta = { base = "#BFAEFF", bright = "#C9BBFF", dim = "#9E84FF" },
    cyan = { base = "#6E79FF", bright = "#8F98FF", dim = "#5966FF" },
    yellow = { base = "#92EC97", bright = "#A3FF9A", dim = "#7EEC84" },
    orange = { base = "#C8FFCB", bright = "#E3FFE4", dim = "#BEFEC0" },
    pink = { base = "#F3A9C4", bright = "#FFC6DE", dim = "#FFB4D3" },
    red = { base = "#FFDDE3", bright = "#FFD6DD", dim = "#F1CFD4"},
}

local skyrise = {
    bg0 = "#0E0F11",
    bg1 = "#131416",
    bg2 = "#25282D",
    bg3 = "#353A42",
    bg4 = "#535B68",
    sel0 = "#2C3035",
    sel1 = "#525A66",
    blue = { base = "#F6DEA4", bright = "#FFEBBA", dim = "#FBE2A6" },
    green = { base = "#FAC5EB", bright = "#FFD9F4", dim = "#FFC9E3" },
    magenta = { base = "#ABCFF5", bright = "#C4E1FF", dim = "#A0DAFF" },
    cyan = { base = "#A8A7F3", bright = "#C5C4FF", dim = "#A0ABFF" },
    yellow = { base = "#F7BB99", bright = "#FFCAAD", dim = "#FAB48E" },
    orange = { base = "#F7CA95", bright = "#FFD7A9", dim = "#FFC785" },
    pink = { base = "#F8B7D8", bright = "#FFCBE5", dim = "#FFB7DB" },
    red = { base = "#C4A6F5", bright = "#DAC4FF", dim = "#C29DFF"},
}

return {
    "EdenEast/nightfox.nvim",
    config = function()
        require("nightfox").setup({
            palettes = {
                carbonfox = skyrise
            }
        })
        vim.opt.background = "dark"
        vim.cmd([[colorscheme carbonfox]])
        vim.cmd([[hi normal guibg=NONE]])
    end,
    priority = 1000,
}
