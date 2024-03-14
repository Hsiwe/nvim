require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "eslint" },
})
local telescope_builtin = require("telescope.builtin")

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	require("lsp-overloads").setup(client, {})

	vim.keymap.set(
		{ "n", "i" },
		"<A-s>",
		":LspOverloadsSignature<CR>",
		{ noremap = true, silent = true, buffer = bufnr }
	)
	vim.keymap.set("i", "<A-s>", function()
		vim.cmd("LspOverloadsSignature")
	end, { noremap = true, silent = true, buffer = bufnr })

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "gh", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>fs", function()
		vim.ui.input({ prompt = "Workspace symbols: " }, function(query)
			telescope_builtin.lsp_workspace_symbols({ query = query })
		end)
	end, { desc = "LSP workspace symbols" })
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "<leader>vD", function()
		telescope_builtin.diagnostics()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vr", function()
		telescope_builtin.lsp_references()
	end, opts)
	vim.keymap.set("n", "<leader>vn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<c-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end

require("typescript-tools").setup({
	on_attach = on_attach,
	settings = {
		separate_diagnostic_server = true,
		publish_diagnostic_on = "change",
		tsserver_plugins = {},
		tsserver_format_options = {},
		tsserver_file_preferences = {},
	},
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "nvim_lsp", max_item_count = 10 },
		{
			name = "buffer",
			keyword_length = 3,
			max_item_count = 10,
			option = {
				get_bufnrs = function()
					local buf = vim.api.nvim_get_current_buf()
					local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
					if byte_size > 1024 * 1024 * 3 then -- 3 Megabyte max
						return {}
					end
					return { buf }
				end,
			},
		},
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<C-s>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() and cmp.get_active_entry() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			end,
			s = cmp.mapping.confirm({ select = true }),
			c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		}),
	}),
})
