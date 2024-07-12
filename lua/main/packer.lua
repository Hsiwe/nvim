-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		-- or                            , branch = '0.1.x',
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
	})

	use({
		"rose-pine/neovim",
		as = "rose-pine",
	})

	use({
		"eldritch-theme/eldritch.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	})

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("nvim-treesitter/playground", { run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-context")
	use("mbbill/undotree")
	use("machakann/vim-sandwich")
	use("tpope/vim-fugitive")

	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			--- Uncomment the two plugins below if you want to manage the language servers from neovim
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			-- Autocompletion
			{ "L3MON4D3/LuaSnip" },
		},
	})
	use({
		"pmizio/typescript-tools.nvim",
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("typescript-tools").setup({})
		end,
	})
	use({ "Issafalcon/lsp-overloads.nvim" })

	use("MunifTanjim/eslint.nvim")
	use({
		"nvim-telescope/telescope-project.nvim",
		config = function()
			require("telescope").load_extension("project")
			require("telescope").load_extension("aerial")
		end,
	})
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use("MunifTanjim/prettier.nvim")
	use({
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"folke/todo-comments.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	})
	use("mrjones2014/smart-splits.nvim")

	use({
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					javascript = { "eslint_d" },
					typescript = { "eslint_d" },
					javascriptreact = { "eslint_d" },
					typescriptreact = { "eslint_d" },
					json = { "prettier" },
					lua = { "stylua" },
				},
			})

			conform.formatters.eslint_d = { command = "eslint_d" }

			vim.keymap.set({ "n", "v" }, "<leader>f", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end)
		end,
	})

	use({
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

			-- vim.keymap.set("n", "<leader>l", function()
			-- 	lint.try_lint()
			-- end)
		end,
	})

	use({
		"mrcjkb/haskell-tools.nvim",
		version = "^3",
		ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
	})

	use({
		"stevearc/aerial.nvim",
	})
	use("cedarbaum/fugitive-azure-devops.vim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	-- use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
	-- use({
	-- "microsoft/vscode-js-debug",
	-- opt = true,
	-- run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	-- })
	-- use({
	-- 	"mfussenegger/nvim-dap",
	-- 	opt = true,
	-- 	module = { "dap" },
	-- 	requires = {
	-- 		"theHamsta/nvim-dap-virtual-text",
	-- 		"rcarriga/nvim-dap-ui",
	-- 		"nvim-telescope/telescope-dap.nvim",
	-- 		{ "jbyuki/one-small-step-for-vimkind", module = "osv" },
	-- 		{ "mxsdev/nvim-dap-vscode-js", module = { "dap-vscode-js" } },
	-- 		{
	-- 			"microsoft/vscode-js-debug",
	-- 			opt = true,
	-- 			run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	-- 		},
	-- 	},
	-- 	disable = false,
	-- })

	use("lewis6991/gitsigns.nvim")
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-buffer" })

	-- Snippets
	use({
		"L3MON4D3/LuaSnip", -- snippet engine
		opts = {
			history = true,
			delete_check_events = "TextChanged",
			-- updateevents = "TextChanged,TextChangedI",
			-- autosnippets = true,
		},
		config = function()
			-- this is the function that loads the extra snippets to luasnip
			-- from rafamadriz/friendly-snippets
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	})
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "rafamadriz/friendly-snippets" })
	use({
		"letieu/btw.nvim",
		config = function()
			require("btw").setup()
		end,
	})

	use({
		"Exafunction/codeium.vim",
		config = function()
			vim.g.codeium_manual = true
		end,
	})

	-- Uncomment for keybinding debugging
	-- use({
	-- 	"folke/which-key.nvim",
	-- 	config = function()
	-- 		vim.o.timeout = true
	-- 		vim.o.timeoutlen = 300
	-- 		require("which-key").setup({
	-- 		})
	-- 	end,
	-- })

	use({
		"Equilibris/nx.nvim",
		requires = {
			"nvim-telescope/telescope.nvim",
		},
	})

	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})

	use({
		"NeogitOrg/neogit",
		requires = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("neogit").setup({})
		end,
	})

	use("nvim-tree/nvim-web-devicons")
end)
