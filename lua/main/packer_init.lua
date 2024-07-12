local packer = require("packer")
packer.util = require("packer.util")

packer.init({
	compile_path = vim.fn.stdpath("data") .. "/site/pack/loader/start/packer.nvim/plugin/packer.lua",
})
