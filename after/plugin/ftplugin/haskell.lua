local telescope_builtin = require("telescope.builtin")

local on_attach = function(_, bufnr)
	local ht = require("haskell-tools")

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

	vim.keymap.set("n", "<leader>hs", ht.hoogle.hoogle_signature, opts)
	vim.keymap.set("n", "<leader>ea", ht.lsp.buf_eval_all, opts)

	vim.keymap.set("n", "<leader>rr", ht.repl.toggle, opts)
	vim.keymap.set("n", "<leader>rf", function()
		ht.repl.toggle(vim.api.nvim_buf_get_name(0))
	end, opts)

	vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)

	vim.keymap.set("n", "<leader>rq", ht.repl.quit, opts)

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "gh", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>ws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
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
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<c-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
    -- Unmapping ghc keybinding which stands for ReplTools from haskel-tools
    -- library. I don't need it and I'm used to my "gh" mapping for hover.
	vim.keymap.del("n", "ghc")
end

vim.g.haskell_tools = {
	hls = {
		on_attach = on_attach,
		settings = {
			haskell = {
				plugin = {
					class = { -- missing class methods
						codeLensOn = true,
					},
					importLens = { -- make import lists fully explicit
						codeLensOn = true,
					},
					refineImports = { -- refine imports
						codeLensOn = true,
					},
					tactics = { -- wingman
						codeLensOn = true,
					},
					moduleName = { -- fix module names
						globalOn = true,
					},
					eval = { -- evaluate code snippets
						globalOn = true,
					},
					["ghcide-type-lenses"] = { -- show/add missing type signatures
						globalOn = true,
					},
				},
			},
		},
	},
}
