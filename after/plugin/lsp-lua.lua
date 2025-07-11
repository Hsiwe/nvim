require("lspconfig").lua_ls.setup({
	on_init = function(client)
		local opts = { remap = false }

		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		local telescope_builtin = require("telescope.builtin")

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

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = true,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/rest/library",
					-- "${3rd}/busted/library",
				},
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				-- library = vim.api.nvim_get_runtime_file("", true)
			},
		})
	end,
	settings = {
		Lua = {},
	},
})
