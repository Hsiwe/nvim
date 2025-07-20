local telescope = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")
local actions = require("telescope.actions")
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
local project_actions = require("telescope._extensions.project.actions")
local project_utils = require("telescope._extensions.project.utils")
local builtin = require("telescope.builtin")

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
		project = {
			on_project_selected = function(prompt_bufnr)
				local project_path = project_actions.get_selected_path(prompt_bufnr)
				actions._close(prompt_bufnr, true)
				project_utils.change_project_dir(project_path, "cd")
			end,
			cd_scope = { "global" },
		},
	},
})

telescope.load_extension("project")
telescope.load_extension("aerial")
telescope.load_extension("live_grep_args")
telescope.load_extension("ui-select")

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
