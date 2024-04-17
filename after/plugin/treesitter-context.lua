require'treesitter-context'.setup{
  max_lines = 4, -- How many lines the window should span. Values <= 0 mean no limit.
  line_numbers = true,
}

vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })
