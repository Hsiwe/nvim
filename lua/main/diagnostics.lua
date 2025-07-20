local config = {
	virtual_lines = {
		current_line = true,
		format = function(diagnostic)
			local message = diagnostic.message
			if string.len(message) > 300 then
				return string.sub(message, 1, 300) .. "..."
			end
			return message
		end,
	},
}

vim.diagnostic.config(config)

vim.keymap.set("n", "<leader>td", function()
	config.virtual_lines.current_line = not config.virtual_lines.current_line
	vim.diagnostic.config(config)
end, { desc = "Toggle diagnostic virtual_lines" })
