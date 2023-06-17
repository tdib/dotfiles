require 'core'

local custom_init_path = vim.api.nvim_get_runtime_file('lua/custom/init.lua', false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require('core.utils').load_mappings()

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require('core.bootstrap').gen_chadrc_template()
  require('core.bootstrap').lazy(lazypath)
end

dofile(vim.g.base46_cache .. 'defaults')
vim.opt.rtp:prepend(lazypath)
require 'plugins'

local lspconfig = require 'lspconfig'

-- Terminal mode to NTerminal mode
vim.api.nvim_set_keymap('t', '<C-space>', '<C-\\><C-n>', {noremap = true})
vim.api.nvim_set_keymap('t', '<Esc><Esc>', '<C-\\><C-n>', {noremap = true})

-- Terminal mode to other buffer
vim.api.nvim_exec([[
  let $ORIGINAL_CTRL=$CTRL
  let $CTRL=1
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
  autocmd vimLeave * let $CTRL=$ORIGINAL_CTRL
]], false)

-- ctrl/option backspace clear full words in insert mode
-- comments with ctrl/cmd slash
-- find out how to move from comment line to no comment line (i.e. without auto comment)
-- terminal in current working dir



-- TODO: unbind C-] and -
local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true
    }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '[', api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', ']', api.tree.change_root_to_node,        opts('CD'))
end

-- pass to setup along with your other options
require("nvim-tree").setup {
  on_attach = my_on_attach,
}


