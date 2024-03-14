require("telescope").setup({
	defaults = {
		path_display = { "truncate" },
	},
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<C-y>", function()
	require("telescope").extensions.project.project({})
end)
vim.keymap.set("n", "<leader>pS", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>ps", function()
	builtin.live_grep({ search = vim.fn.input("Live grep > ") })
end)
vim.keymap.set("n", "<leader>o", function()
	require("telescope").extensions.aerial.aerial({})
end)
