require("overseer").setup({
	task_list = {
		bindings = {
			["<C-l>"] = false,
			["<C-h>"] = false,
			["<C-j>"] = false,
			["<C-k>"] = false,
			["ol"] = "IncreaseDetail",
			["oh"] = "DecreaseDetail",
		},
	},
})

vim.keymap.set("n", "<leader>tr", ":OverseerRun<CR>")
vim.keymap.set("n", "<leader>to", ":OverseerOpen<CR>")
