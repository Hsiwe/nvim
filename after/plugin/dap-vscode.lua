local dap = require("dap")
local dapui = require("dapui")
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

require("dap-vscode-js").setup({
	debugger_path = "/home/hsiwe/nvim-utils/vscode-js-debug",
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
})

for _, language in ipairs({ "typescript", "javascript" }) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			-- localRoot = vim.fn.getcwd(),
			cwd = "${workspaceFolder}",
			-- websocketAddress = "ws://127.0.0.1:9229"
			-- websocketAddress = function()
			-- 	return string.match(
			-- 		vim.api.nvim_exec('!docker logs [conatiner-name]|& grep -oE "ws.*" | tail -1', true),
			-- 		"ws:.*"
			-- 	)
			-- end,
		},
	}
end

vim.keymap.set("n", "<F2>", function()
	dap.toggle_breakpoint()
end)

vim.keymap.set("n", "<F3>", function()
	dap.repl.open()
end)

vim.keymap.set("n", "<F4>", function()
	dapui.toggle()
end)

vim.keymap.set("n", "<F5>", function()
	dap.continue()
end)

vim.keymap.set("n", "<F10>", function()
	dap.step_over()
end)

vim.keymap.set("n", "<F11>", function()
	dap.step_into()
end)

vim.keymap.set({"n", "v"}, "<leader>gdh", function()
    dapui.eval()
end)

