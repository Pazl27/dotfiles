 return {
   'akinsho/toggleterm.nvim',
   version = "*",
   opts = {
     -- i want the terminal to open in the same directory as the current file
     -- this is the default behavior
     -- open terminal as a hover window
   },
   config = function()
    require("toggleterm").setup {
	    size = 10,
	    open_mapping = [[<C-\>]],
	    start_in_insert = true,
	    direction = "float", -- or "horizontal" or "vertical"
	    shell = "pwsh.exe",
	    float_opts = {
		    border = "curved",
		    width = math.ceil(vim.o.columns*0.8),
		    height = math.ceil(vim.o.columns*0.2)
	    }
    }
   end,
}
