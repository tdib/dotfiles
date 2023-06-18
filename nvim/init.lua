require('nvim.packer_config')

-- ctrl/option backspace clear full words in insert mode
-- find out how to move from comment line to no comment line (i.e. without auto comment)
-- terminal in current working dir
-- unbind C-] and -
-- nvim copy/paste from clipboard
-- themes panel/more themes
-- display gitignored files in the file tree
-- tabs for open files
-- status line
-- whichkey.nvim config
-- don't comment empty line
-- ctrl+k in nvim tree command clash

local set_keymap = vim.keymap.set
local opt = vim.opt
vim.g.mapleader = ' '

---------- GENERAL ----------
-- Set indentation variables
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Line numbers
opt.nu = true

-- Vim uses regular clipboard instead of vim buffer
opt.clipboard = 'unnamedplus'

-- Alt+j/k to shift line down/up
set_keymap('n', '<A-j>', ':move +1<CR>', { noremap=true, silent = true })
set_keymap('n', '<A-k>', ':move -2<CR>', { noremap=true, silent = true })

-- Terminal mode to NTerminal mode
set_keymap('t', '<C-space>', '<C-\\><C-n>', { noremap=true })
set_keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { noremap=true })

-- Allow movement between windows using vim motion keys
set_keymap('n', '<C-h>', '<C-w>h', { noremap=true })
set_keymap('n', '<C-j>', '<C-w>j', { noremap=true })
set_keymap('n', '<C-k>', '<C-w>k', { noremap=true })
set_keymap('n', '<C-l>', '<C-w>l', { noremap=true })

-- Allow movement between buffers using tab/shift-tab
set_keymap('n', '<Tab>', ':bnext<CR>', { noremap=true })
set_keymap('n', '<S-Tab>', ':bprev<CR>', { noremap=true })

-- Disable highlighting
set_keymap('n', '<Esc>', ':noh<CR>', { noremap=true, silent=true })
-----------------------------






---------- NEODEV ----------
require('neodev').setup()
----------------------------






---------- COMMENT ----------
local comment = require('Comment.api')

-- Single line commenting with Ctrl+/
set_keymap("n", "<C-_>", comment.toggle.linewise.current, { noremap=true })
set_keymap("i", "<C-_>", comment.toggle.linewise.current, { noremap=true })

-- Multi-line commenting with Ctrl+/ (kinda janky)
local esc = vim.api.nvim_replace_termcodes(
	'<ESC>', true, false, true
)
vim.keymap.set('x', '<C-_>', function()
	vim.api.nvim_feedkeys(esc, 'nx', false)
	comment.toggle.linewise(vim.fn.visualmode())
end)
-----------------------------


---------- FUGITIVE ----------
set_keymap('n', '<leader>gs', vim.cmd.Git)
------------------------------



---------- HARPOON ----------
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

set_keymap('n', '<leader>a', mark.add_file)
set_keymap('n', '<C-e>', ui.toggle_quick_menu)

set_keymap('n', '<C-1>', function() ui.nav_file(1) end)
set_keymap('n', '<C-2>', function() ui.nav_file(2) end)
-----------------------------



---------- LSP ZERO ----------
local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
	'rust_analyzer',
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-Space>'] = cmp.mapping.complete(),
	['<CR>'] = cmp.mapping.confirm({ select = true }),
})
lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})


lsp.set_preferences({
	sign_icons = { }
})


lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	set_keymap("n", "gd", function() vim.lsp.buf.definition() end, opts)
	set_keymap("n", "K", function() vim.lsp.buf.hover() end, opts)
	set_keymap("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	set_keymap("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	set_keymap("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	set_keymap("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	set_keymap("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	set_keymap("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	set_keymap("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	set_keymap("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()
------------------------------





---------- NVIM TREE ----------
-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
})

local api = require('nvim-tree.api')

set_keymap('n', '[', api.tree.change_root_to_parent, { noremap=true })
set_keymap('n', ']', api.tree.change_root_to_node, { noremap=true })

set_keymap('n', '<C-n>', api.tree.toggle)
-------------------------------






---------- TELESCOPE ----------
local builtin = require('telescope.builtin')

set_keymap('n', '<leader>f', builtin.find_files, {})
set_keymap('n', '<C-p>', builtin.git_files, {})

require('nvim-treesitter.configs').setup {
  -- A list of parser names, or 'all' (the five listed parsers should always be installed)
  ensure_installed = { 'javascript', 'typescript', 'c', 'lua', 'vim', 'vimdoc', 'query' },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = '/some/path/to/store/parsers', -- Remember to run vim.opt.runtimepath:append('/some/path/to/store/parsers')!
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
-------------------------------





---------- UNDO TREE ----------
set_keymap('n', '<leader>u', vim.cmd.UndotreeToggle)
-------------------------------
