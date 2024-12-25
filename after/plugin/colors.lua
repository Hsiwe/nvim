local builtin = require("rose-pine")
builtin.setup({
	styles = {
		italic = false,
	},
})

require("eldritch").setup({
	transparent = false, -- Enable this to disable setting the background color
	styles = {
		comments = { italic = false },
		keywords = { italic = false },
	},
	on_colors = function(colors)
		colors.fg_gutter_light = colors.fg_gutter
	end,
})

vim.cmd([[colorscheme eldritch]])
-- vim.cmd("colorscheme rose-pine-moon")
