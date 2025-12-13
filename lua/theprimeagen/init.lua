require("theprimeagen.set")
require("theprimeagen.remap")
require("theprimeagen.lazy_init")

-- DO.not
-- DO NOT INCLUDE THIS

-- If i want to keep doing lsp debugging
-- function restart_htmx_lsp()
--     require("lsp-debug-tools").restart({ expected = {}, name = "htmx-lsp", cmd = { "htmx-lsp", "--level", "DEBUG" }, root_dir = vim.loop.cwd(), });
-- end

-- DO NOT INCLUDE THIS
-- DO.not

local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup('ThePrimeagen', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- Colorscheme is set once at startup via lazy config
-- Don't reload on every buffer enter to preserve integration highlights
autocmd('FileType', {
    group = ThePrimeagenGroup,
    pattern = "zig",
    callback = function()
        pcall(vim.cmd.colorscheme, "tokyonight-night")
    end
})

-- Open neo-tree when starting with a directory
autocmd('VimEnter', {
    group = ThePrimeagenGroup,
    callback = function(data)
        -- Check if the argument is a directory
        local directory = vim.fn.isdirectory(data.file) == 1

        if directory then
            -- Change to the directory
            vim.cmd.cd(data.file)
            -- Open neo-tree
            vim.cmd('Neotree show')
        end
    end
})

-- Create a highlight with your terminal's actual background
-- Change #000000 to your terminal's background color (black, or whatever it is)
vim.api.nvim_set_hl(0, "TerminalBG", { bg = "#000000", fg = "#ffffff" })

autocmd('ColorScheme', {
    group = ThePrimeagenGroup,
    callback = function()
        -- Recreate after colorscheme loads
        vim.api.nvim_set_hl(0, "TerminalBG", { bg = "#000000", fg = "#ffffff" })
    end
})

-- Apply to terminal windows when they open
autocmd('TermOpen', {
    group = ThePrimeagenGroup,
    callback = function()
        -- Use a different background color for terminal
        vim.wo.winhighlight = "Normal:TerminalBG,NormalNC:TerminalBG"
    end
})


autocmd('LspAttach', {
    group = ThePrimeagenGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})

-- Set 2-space indentation for JavaScript/TypeScript files
autocmd('FileType', {
    group = ThePrimeagenGroup,
    pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'json', 'html', 'css', 'jsx', 'tsx' },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true
    end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
