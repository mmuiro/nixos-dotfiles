local colors = {
    lightgreen = "#CEFFE2",
    green = "#ABF3BB",
    lightblue = "#C4E1FF",
    yellow = "#FFEBBA",
    orange = "#FFCAAD",
    pink = "#F3A9C4",
    sakura = "#FFDDE3",
    purple = "#BFAEFF",
    darkpurple = "#6E79FF",
    gray1 = "#25282D",
    gray2 = "#36393D",
    gray3 = "#434746",
    gray4 = "#A7ADAA",
    white = "#FAFFFB"
}

local limefrost_lualine = {
    normal = {
        a = { bg = colors.lightgreen, fg = colors.gray1, gui = "bold" },
        b = { bg = colors.gray3, fg = colors.lightgreen },
        c = { b,g = colors.gray2, fg = colors.gray4 },
    },
    insert = {
        a = { bg = colors.sakura, fg = colors.gray1, gui = "bold" },
        b = { bg = colors.gray3, fg = colors.sakura },
        c = { bg = colors.gray2, fg = colors.gray4 },
    },
    visual = {
        a = { bg = colors.darkpurple, fg = colors.gray1, gui = "bold" },
        b = { bg = colors.gray3, fg = colors.darkpurple },
        c = { bg = colors.gray2, fg = colors.gray4 },
    },
    replace = {
        a = { bg = colors.pink, fg = colors.gray1, gui = "bold" },
        b = { bg = colors.gray3, fg = colors.pink },
        c = { bg = colors.gray2, fg = colors.gray4 },
    },
    command = {
        a = { bg = colors.green, fg = colors.gray1, gui = "bold" },
        b = { bg = colors.gray3, fg = colors.green },
        c = { bg = colors.gray2, fg = colors.gray4 },
    },
    inactive = {
        a = { bg = colors.gray1, fg = colors.gray3, gui = "bold" },
        b = { bg = colors.gray1, fg = colors.gray3 },
        c = { bg = colors.gray1, fg = colors.gray3 },
    },
}

local skyrise_lualine = {
    normal = {
        a = { bg = colors.lightblue, fg = colors.gray1, gui = "bold" },
        b = { bg = colors.gray3, fg = colors.lightblue },
        c = { bg = colors.gray2, fg = colors.gray4 },
    },
    insert = {
        a = { bg = colors.sakura, fg = colors.gray1, gui = "bold" },
        b = { bg = colors.gray3, fg = colors.sakura },
        c = { bg = colors.gray2, fg = colors.gray4 },
    },
    visual = {
        a = { bg = colors.orange, fg = colors.gray1, gui = "bold" },
        b = { bg = colors.gray3, fg = colors.orange },
        c = { bg = colors.gray2, fg = colors.gray4 },
    },
    replace = {
        a = { bg = colors.yellow, fg = colors.gray1, gui = "bold" },
        b = { bg = colors.gray3, fg = colors.yellow },
        c = { bg = colors.gray2, fg = colors.gray4 },
    },
    command = {
        a = { bg = colors.white, fg = colors.gray1, gui = "bold" },
        b = { bg = colors.gray3, fg = colors.white },
        c = { bg = colors.gray2, fg = colors.gray4 },
    },
    inactive = {
        a = { bg = colors.gray1, fg = colors.gray3, gui = "bold" },
        b = { bg = colors.gray1, fg = colors.gray3 },
        c = { bg = colors.gray1, fg = colors.gray3 },
    },
}

return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require('lualine').setup({
            options = {
                theme = skyrise_lualine,
                section_separators = "",
                component_separators = "",
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'buffers' },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            }
        })
    end,
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
    },
}
