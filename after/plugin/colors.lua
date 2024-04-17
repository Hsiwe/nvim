local builtin = require("rose-pine")
builtin.setup({
	styles = {
		italic = false,
	},
})

require("eldritch").setup({
	transparent = true, -- Enable this to disable setting the background color
	styles = {
		comments = { italic = false },
		keywords = { italic = false },
	},
})

vim.cmd([[colorscheme eldritch]])
-- vim.cmd("colorscheme rose-pine-moon")
