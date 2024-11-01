-- find out how to move from comment line to no comment line (i.e. without auto comment)
-- terminal plugin - TODO: set up
-- terminal in current working dir
-- more themes
-- themes persist across sessions
-- status line
-- whichkey.nvim config
-- don't comment empty line
-- don't unselect after multi-line comment
-- line uncommenting to work properly when empty lines are selected
-- comment in insert mode send cursor after comment
-- ctrl+c copy in visual mode
-- auto indent after pasting?
-- auto close brackets?
-- tab to auto complete suggestion
-- copilot to work properly (tab issue)
-- long inlay hints to wrap
-- ctrl+e in nvimtree directory buffer seems to open the cursor file
-- buffer deletion delay

local opt = vim.opt
local set_keymap = vim.keymap.set
vim.g.mapleader = " "

-- Function to merge two tables
local function extend_opts(opts, extra_opts)
    return vim.tbl_extend("force", opts, extra_opts)
end

-- Bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
opt.rtp:prepend(lazypath)

local plugins = require("dib.plugins")
require("lazy").setup(plugins)


---------- GENERAL ----------
-- Set indentation variables
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Line numbers
opt.nu = true

-- Searching is case insensitive unless there is an uppercase letter in the search term
opt.ignorecase = true
opt.smartcase = true

-- Vim uses regular clipboard instead of vim buffer
opt.clipboard = "unnamedplus"

-- Set default theme
vim.cmd([[colorscheme habamax]])

-- Alt+j/k to shift line down/up
set_keymap("n", "<A-j>", ":move +1<CR>==", { noremap = true, silent = true, desc = "Shift line down" })
set_keymap("n", "<A-k>", ":move -2<CR>==", { noremap = true, silent = true, desc = "Shift line up" })
set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Shift lines up" })
set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Shift lines up" })

-- Allow opt+backspace for removing words in insert mode
set_keymap("i", "<A-BS>", "<C-W>")

-- Ctrl+s to save buffer
set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, desc = "Save buffer" })
set_keymap("i", "<C-s>", "<cmd>w<CR>", { noremap = true, desc = "Save buffer" })

-- Terminal mode to NTerminal mode
-- set_keymap("t", "<C-space>", "<C-\\><C-n>", { noremap = true, desc = "Open terminal" })
-- set_keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, desc = "Open terminal" })

-- Allow movement between windows using vim motion keys
set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, desc = "Shift focus to left window" })
set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, desc = "Shift focus to below window" })
set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, desc = "Shift focus to above window" })
set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, desc = "Shift focus to right window" })

-- Allow movement between buffers using tab/shift-tab
set_keymap("n", "<A-l>", ":BufferNext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
set_keymap("i", "<A-l>", "<ESC>:BufferNext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
set_keymap("n", "<A-h>", ":BufferPrev<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
set_keymap("i", "<A-h>", "<ESC>:BufferPrev<CR>", { noremap = true, silent = true, desc = "Previous buffer" })

-- Disable highlighting w/ esc
set_keymap("n", "<Esc>", ":noh<CR>", { noremap = true, silent = true, desc = "Remove text highlight" })

-- Visible whitespace
vim.cmd("set list")
vim.cmd("set listchars=tab:»\\ ")
vim.cmd("set listchars+=space:·")
-----------------------------

---------- NEODEV ----------
require("lazydev").setup()
----------------------------

---------- LSP-ZERO ----------
local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    "rust_analyzer",
    "basedpyright",
    "lua_ls"
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.on_attach(function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }

    set_keymap("n", "gd", function() vim.lsp.buf.definition() end, extend_opts(opts, { desc = "Go to definition" }))
    set_keymap("n", "K", function() vim.lsp.buf.hover() end, extend_opts(opts, { desc = "Open definition" }))
    set_keymap("n", "<C-Shift-K>", function() vim.lsp.buf.signature_help() end,
        extend_opts(opts, { desc = "Signature help" }))
    -- set_keymap("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    -- set_keymap("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    set_keymap("n", "[d", function() vim.diagnostic.goto_prev() end,
        extend_opts(opts, { desc = "Go to previous diagnostic" }))
    set_keymap("n", "]d", function() vim.diagnostic.goto_next() end,
        extend_opts(opts, { desc = "Go to next diagnostic" }))
    set_keymap("n", "<leader>vca", function() vim.lsp.buf.code_action() end, extend_opts(opts, { desc = "Code actions" }))
    set_keymap("n", "<leader>vrr", function() vim.lsp.buf.references() end,
        extend_opts(opts, { desc = "Find references" }))
    set_keymap("n", "<leader>vrn", function() vim.lsp.buf.rename() end, extend_opts(opts, { desc = "Rename" }))
end)

lsp.format_on_save({
    servers = {
        ["lua_ls"] = { "lua" },
        ["rust_analyzer"] = { "rust" }
    }
})

-- Remove annoying "Do you need to configure your work environment as `luv` warning
require("lspconfig").lua_ls.setup({
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            }
        }
    },
})

lsp.setup()
-------------------------------




---------- FUGITIVE ----------
set_keymap("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
------------------------------



---------- UNDO TREE ----------
set_keymap("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "View undo tree" })

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
-------------------------------



---------- HARPOON ----------
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

set_keymap("n", "<leader>a", mark.add_file, { desc = "Add file to harpoon" })
set_keymap("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon quick menu" })

set_keymap("n", "<C-1>", function() ui.nav_file(1) end, { desc = "Harpoon file 1" })
set_keymap("n", "<C-2>", function() ui.nav_file(2) end, { desc = "Harpoon file 2" })
-----------------------------



---------- TELESCOPE ----------
require("telescope").setup({
    pickers = {
        colorscheme = {
            enable_preview = true
        }
    },
})
local builtin = require("telescope.builtin")

set_keymap("n", "<leader>f", builtin.find_files, { desc = "Find files" })
set_keymap("n", "<leader>th", builtin.colorscheme, { desc = "Change theme" })
------------------------------



---------- TREESITTER ----------
require("nvim-treesitter.configs").setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Make compiler happy :)
    ignore_install = {},
    modules = {},

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
    auto_install = true,

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}
--------------------------------



---------- COMMENT ----------
--
local comment = require("Comment.api")

-- require("Comment").setup({
--    ignore = true
-- })

-- Single line commenting with Ctrl+/
set_keymap("n", "<C-/>", comment.toggle.linewise.current, { noremap = true, desc = "Toggle comment" })
set_keymap("i", "<C-/>", comment.toggle.linewise.current, { noremap = true, desc = "Toggle comment" })
set_keymap("n", "<leader>c", comment.toggle.linewise.current, { noremap = true, desc = "Toggle comment" })

-- Multi-line commenting with Ctrl+/ (kinda janky)
local esc = vim.api.nvim_replace_termcodes(
    "<ESC>", true, false, true
)
vim.keymap.set("x", "<C-/>", function()
    vim.api.nvim_feedkeys(esc, "nx", false)
    comment.toggle.linewise(vim.fn.visualmode())
end)
-----------------------------



---------- NVIM TREE ----------
-- Disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Set termguicolors to enable highlight groups
-- vim.opt.termguicolors = true

local function on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    -- set_keymap("n", "<leader>mn", api.marks.navigate.next, opts("Next Bookmark"))
    -- set_keymap("n", "<leader>mp", api.marks.navigate.prev, opts("Previous Bookmark"))
    set_keymap("n", "<C-k>", api.tree.change_root_to_parent, opts("Navigate to parent directory"))
    set_keymap("n", "<C-j>", api.tree.change_root_to_node, opts("Navigate to child directory"))
    vim.keymap.set("n", "P", function()
        local node = api.tree.get_node_under_cursor()
        print(node.absolute_path)
    end, opts("Print Node Path"))
end
require("nvim-tree").setup({
    on_attach = on_attach,
    git = {
        ignore = false
    }
})
-- #HACK, fix
set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle directory tree view" })
set_keymap("n", "<leader>b", ":NvimTreeFindFile<CR>", { desc = "Find current file in tree" })
-------------------------------




---------- BARBAR ----------
require("barbar").setup({
    sidebar_filetypes = {
        NvimTree = true,
    },
    no_name_title = "New Buffer"
})

set_keymap("n", "<leader>x", ":BufferClose<CR>", { noremap = true, silent = true, desc = "Close buffer" })
----------------------------



---------- TOGGLETERM ----------
local toggle_term = require("toggleterm")
toggle_term.setup()
-- Allow traversal keybinds from terminal
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    set_keymap("t", "<esc>", [[<C-\><C-n>]], opts)
    set_keymap("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
    set_keymap("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
    set_keymap("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
    set_keymap("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
    set_keymap("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal
local floating_term = Terminal:new({ direction = "float" })

function _G.toggle_floating_term()
    floating_term:toggle()
end

set_keymap("n", "<C-\\>", "<cmd>lua toggle_floating_term()<CR>", { noremap = true, desc = "Toggle floating terminal" })
set_keymap("t", "<C-\\>", "<cmd>lua toggle_floating_term()<CR>", { noremap = true, desc = "Toggle floating terminal" })
-- set_keymap("n", "<leader>a", "lua open_term_at_nvim_tree_root()<CR>", { noremap=true })


function _G.open_term_at_nvim_tree_root()
    -- Save the current window number
    local current_winnr = vim.api.nvim_eval("winnr()")

    -- Find the file in NvimTree
    -- vim.cmd("NvimTreeFindFile")

    -- Save the directory of the NvimTree root
    local root_dir = vim.fn.expand("%:p:h")

    -- Return to the original window
    vim.cmd(current_winnr .. "wincmd w")

    -- Open terminal
    require("toggleterm").toggle()

    -- Change directory to the saved root_dir
    vim.cmd("silent! !cd " .. root_dir)
end

-- Map the function to a key
set_keymap("n", "<F5>", ":lua _G.open_term_at_nvim_tree_root()<CR>",
    { noremap = true, silent = true, desc = "Open directory tree at root" })
-----------------------------------


---------- RUST-TOOLS ----------
-- require("rust-tools").setup()
--------------------------------
