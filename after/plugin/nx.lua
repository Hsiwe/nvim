require("nx").setup({
	nx_cmd_root = "pnpm nx",

	-- Command running capabilities,
	-- see nx.m.command-runners for more details
	command_runner = require("nx.command-runners").terminal_cmd(),
	-- Form rendering capabilities,
	-- see nx.m.form-renderers for more detials
	form_renderer = require("nx.form-renderers").telescope(),

	-- Whether or not to load nx configuration,
	-- see nx.loading-and-reloading for more details
	read_init = true,
})
