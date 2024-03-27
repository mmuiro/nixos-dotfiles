local limefrost_tabby = {
    fill = "TabLineFill",
    -- Also you can do this: fill = { fg="#f2e9de", bg="#907aa9", style="italic" }
    head = "TabLine",
    win = { bg = "#6E79FF", fg = "#FAFFFB" },
    tab = { bg = "#4D5054", fg = "#25282D" },
    current_tab = { bg = "#36393D", fg = "#FAFFFB" },
    tail = "TabLine",
    ends = { bg = "#CEFFE2", fg = "#25282D" },
}

local skyrise_tabby = {
    fill = "TabLineFill",
    head = "TabLine",
    win = { bg = "#FFCBE5", fg = "#25282D" },
    tab = { bg = "#4D5054", fg = "#25282D" },
    current_tab = { bg = "#36393D", fg = "#FAFFFB" },
    tail = "TabLine",
    ends = { bg = "#C4E1FF", fg = "#25282D" },
}

local theme = skyrise_tabby

local tabline_renderer = function(line)
    return {
        {
            { "  ", hl = theme.ends },
            line.sep("", theme.ends, theme.fill),
        },
        line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
                line.sep("", hl, theme.fill),
                tab.is_current() and "󱓻" or "󱓼",
                tab.number(),
                tab.name(),
                tab.close_btn(""),
                line.sep("", hl, theme.fill),
                hl = hl,
                margin = " ",
            }
        end),
        line.spacer(),
        line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            return {
                line.sep("", theme.win, theme.fill),
                win.is_current() and "󰔶" or "󰔷",
                win.buf_name(),
                line.sep("", theme.win, theme.fill),
                hl = theme.win,
                margin = " ",
            }
        end),
        {
            line.sep("", theme.ends, theme.fill),
            { " 󰈙 ", hl = theme.ends },
        },
        hl = theme.fill,
    }
end

return {
    "nanozuki/tabby.nvim",
    config = function()
        require("tabby").setup()
        require("tabby.tabline").set(tabline_renderer)
    end,
}
