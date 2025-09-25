local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)
opt.scrolloff = 8

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

local setIndentGroup = vim.api.nvim_create_augroup("setIndent", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = setIndentGroup,
  pattern = { "c", "cpp", "h", "hpp" },
  command = "setlocal shiftwidth=4 tabstop=4"
})

vim.diagnostic.config { virtual_text = true }

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
-- opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- for obsidian
opt.conceallevel = 1

-- colors
vim.o.termguicolors = true

-- completion
vim.g.copilot_filetypes = { ['typr'] = false }

vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- spell check
opt.spelllang = "en,de"
opt.spell = true

-- remove statusline for telescope and tree
opt.laststatus = 3
