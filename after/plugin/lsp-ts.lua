require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "eslint" },
	automatic_enable = false,
})
local telescope_builtin = require("telescope.builtin")

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	require("lsp-overloads").setup(client, {
		display_automatically = false,
	})

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
	vim.keymap.set("n", "gt", function()
		vim.lsp.buf.type_definition()
	end, opts)
	vim.keymap.set("n", "gh", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>ws", function()
		vim.ui.input({ prompt = "Workspace symbols: " }, function(query)
			telescope_builtin.lsp_workspace_symbols({ query = query })
		end)
	end, { desc = "LSP workspace symbols" })
	vim.keymap.set("n", "<leader>wS", function()
		telescope_builtin.lsp_workspace_symbols({ query = vim.fn.expand("<cword>") })
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
	vim.keymap.set({ "n", "v" }, "<leader>vc", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vr", function()
		telescope_builtin.lsp_references()
	end, opts)
	vim.keymap.set("n", "<leader>vn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "<leader>ti", function()
		vim.lsp.inlay_hint.enable()
	end, { desc = "LSP: [T]oggle [I]nlay Hints" })
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
