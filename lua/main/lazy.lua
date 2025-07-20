require("lazy").setup({
	spec = {
		{
			"nvim-telescope/telescope.nvim",
			dependencies = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-telescope/telescope-live-grep-args.nvim" },
				{ "nvim-telescope/telescope-ui-select.nvim" },
			},
		},
		{
			"rose-pine/neovim",
			name = "rose-pine",
		},
		{
			"eldritch-theme/eldritch.nvim",
			priority = 1000,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			-- build = ":TSUpdate",
		},
		{
			"nvim-treesitter/playground",
			-- build = ":TSUpdate",
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
		},
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		{
			"chrisgrieser/nvim-various-textobjs",
			event = "VeryLazy",
			opts = {
				keymaps = {
					useDefaults = true,
				},
			},
		},
		{
			"mbbill/undotree",
		},
		{
			"machakann/vim-sandwich",
		},
		{
			"tpope/vim-fugitive",
		},
		{
			"mason-org/mason.nvim",
			opts = {},
		},
		{
			"L3MON4D3/LuaSnip",
			opts = {},
			lazy = true,
		},
		-- {
		-- 	"neovim/nvim-lspconfig",
		-- 	opts = {},
		-- },
		{
			"pmizio/typescript-tools.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
			opts = {},
		},
		{
			"Issafalcon/lsp-overloads.nvim",
		},
		{
			"MunifTanjim/eslint.nvim",
		},
		{
			"nvim-telescope/telescope-project.nvim",
			dependencies = {
				"nvim-telescope/telescope.nvim",
			},
		},
		{
			"windwp/nvim-autopairs",
			opts = {},
		},
		{
			"MunifTanjim/prettier.nvim",
			opts = {},
		},
		{
			"folke/todo-comments.nvim",
			opts = {},
		},
		{
			"mrjones2014/smart-splits.nvim",
			opts = {},
		},
		{
			"stevearc/conform.nvim",
			opts = {},
			config = function()
				local conform = require("conform")

				conform.setup({
					formatters_by_ft = {
						javascript = { "eslint_d" },
						typescript = { "eslint_d", "prettierd" },
						javascriptreact = { "eslint_d" },
						typescriptreact = { "eslint_d" },
						json = { "prettier" },
						lua = { "stylua" },
					},
				})

				conform.formatters.eslint_d = { command = "eslint_d" }
				conform.formatters.prettierd = { command = "prettierd" }

				vim.keymap.set({ "n", "v" }, "<leader>f", function()
					conform.format({
						bufnr = vim.api.nvim_get_current_buf(),
						lsp_fallback = true,
						async = false,
						timeout_ms = 1000,
					})
				end)
			end,
		},
		{
			"mfussenegger/nvim-lint",
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				local lint = require("lint")
				lint.linters_by_ft = {
					javascript = { "eslint_d" },
					typescript = { "eslint_d" },
					typescriptreact = { "eslint_d" },
					javascriptreact = { "eslint_d" },
				}
				local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

				vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
					group = lint_augroup,
					callback = function()
						lint.try_lint()
					end,
				})
			end,
		},
		{
			"mrcjkb/haskell-tools.nvim",
			version = "^6", -- Recommended
			lazy = false, -- This plugin is already lazy
		},
		{
			"stevearc/aerial.nvim",
		},
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		},
		{
			"mxsdev/nvim-dap-vscode-js",
			dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
		},
		{
			"mfussenegger/nvim-dap",
			commit = "580d6e526358afd0e4bba053e68fd59cf581a161",
		},
		{ "lewis6991/gitsigns.nvim" },
		{
			"numToStr/Comment.nvim",
			opts = {},
		},
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{
			"L3MON4D3/LuaSnip",
			opts = {
				history = true,
				delete_check_events = "TextChanged",
			},
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},

		{ "saadparwaiz1/cmp_luasnip" },
		{ "rcarriga/cmp-dap" },
		{ "rafamadriz/friendly-snippets" },
		{
			"letieu/btw.nvim",
			opts = {},
		},
		{
			"Exafunction/codeium.vim",
			config = function()
				vim.g.codeium_manual = true
			end,
		},
		{
			"iamcco/markdown-preview.nvim",
			build = "cd app && npm install",
			init = function()
				vim.g.mkdp_filetypes = { "markdown", "puml" }
			end,
			ft = { "markdown", "puml" },
		},
		{
			"NeogitOrg/neogit",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"sindrets/diffview.nvim",
				"nvim-telescope/telescope.nvim",
			},
		},
		{ "nvim-tree/nvim-web-devicons" },
		{
			"stevearc/overseer.nvim",
		},
		{
			"ggandor/leap.nvim",
		},
		{
			"otavioschwanck/arrow.nvim",
			opts = {
				show_icons = true,
				leader_key = "<C-e>",
				buffer_leader_key = "<C-w>",
			},
		},
		{
			"gbprod/substitute.nvim",
			opts = {},
		},
		{
			"rmagatti/auto-session",
			lazy = false,
			opts = {
				suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
				cwd_change_handling = true,
				post_cwd_changed_cmds = {
					function()
						local builtin = require("telescope.builtin")
						local auto_session = require("auto-session")
						if auto_session.session_exists_for_cwd() then
							return
						end

						builtin.git_files()
					end,
				},
			},
		},
		{
			"epwalsh/obsidian.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			opts = {
				workspaces = {
					{
						name = "main",
						path = function()
							if vim.loop.os_uname().sysname == "Linux" then
								return "/mnt/c/Users/admin/OneDrive/ObsidianVault/main"
							else
								return "C:\\Users\\admin\\OneDrive\\ObsidianVault\\main"
							end
						end,
					},
				},
			},
			lazy = true,
		},
		{
			"stevearc/oil.nvim",
			opts = {},
		},
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {},
			dependencies = {
				{ "mason-org/mason.nvim", opts = {} },
				"neovim/nvim-lspconfig",
			},
		},

		-- Uncomment for keybinding debugging
		-- {
		-- 	"folke/which-key.nvim",
		-- 	config = function()
		-- 		vim.o.timeout = true
		-- 		vim.o.timeoutlen = 300
		-- 		require("which-key").setup({
		-- 		})
		-- 	end,
		-- }
	},
	checker = { enabled = false },
})
