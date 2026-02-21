return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- v1 does not support lazy-loading
    build = ":TSUpdate",
    config = function()
        -- nvim-treesitter v1 rewrote the API: nvim-treesitter.configs is gone.
        -- Highlight/indent are now built-in Neovim features enabled via autocmd.

        -- Install parsers (no-op if already installed)
        require("nvim-treesitter").install({
            "vimdoc", "javascript", "typescript", "tsx", "c", "lua", "rust",
            "jsdoc", "bash", "json", "html", "css",
        })

        -- Enable treesitter highlighting for all filetypes
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })

        -- Add custom templ parser
        local parsers = require("nvim-treesitter.parsers")
        parsers.templ = {
            install_info = {
                url = "https://github.com/vrischmann/tree-sitter-templ.git",
                files = { "src/parser.c", "src/scanner.c" },
            },
        }

        vim.treesitter.language.register("templ", "templ")
    end
}
