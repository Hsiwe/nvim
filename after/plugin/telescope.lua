local telescope = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")
local actions = require("telescope.actions")
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")

telescope.setup({
	defaults = {
		path_display = { "truncate" },
		cache_picker = {
			num_pickers = 10,
		},
		mappings = {
			i = {
				["<C-space>"] = actions.to_fuzzy_refine,
			},
		},
	},
	extensions = {
		live_grep_args = {
			auto_quoting = true, -- enable/disable auto-quoting
			mappings = { -- extend mappings
				i = {
					["<C-k>"] = lga_actions.quote_prompt(),
					["<C-h>"] = lga_actions.quote_prompt({ postfix = " --hidden" }),
					["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
				},
			},
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- even more opts
			}),
		},
	},
})

telescope.load_extension("live_grep_args")
telescope.load_extension("ui-select")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<C-s>", builtin.search_history, {})
vim.keymap.set("n", "<leader>pp", builtin.pickers, {})
vim.keymap.set("n", "<C-y>", function()
	require("telescope").extensions.project.project({})
end)
vim.keymap.set("n", "<leader>pS", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set("n", "<leader>ps", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

vim.keymap.set("n", "<leader>o", function()
	require("telescope").extensions.aerial.aerial({})
end)
vim.keymap.set("n", "<leader>gc", live_grep_args_shortcuts.grep_word_under_cursor)
vim.keymap.set("v", "<leader>gv", live_grep_args_shortcuts.grep_visual_selection)
