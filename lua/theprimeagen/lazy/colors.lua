function ColorMyPencils(color)
	color = color  or "catppuccin-mocha"
	vim.cmd.colorscheme(color)

	-- Don't override Catppuccin's background colors
	-- If you want transparency, enable it in the Catppuccin config instead
	if color ~= "catppuccin-mocha" and color ~= "catppuccin" then
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end
end

return {

    {
        "erikbackman/brightburn.vim",
    },

    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = {},
        config = function()
            require("tokyonight").setup({
                style = "storm",
                transparent = true,
                terminal_colors = true,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                    sidebars = "dark",
                    floats = "dark",
                },
            })
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function()
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = false,
                bold = true,
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = false,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })
        end,
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                styles = {
                    italic = false,
                },
            })
        end
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                transparent_background = false,
                no_italic = true, -- Disable italics
                term_colors = false, -- Keep your terminal's own color scheme
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    neotree = true,
                    treesitter = true,
                    nvimtree = true,
                    which_key = true,
                    telescope = {
                        enabled = true,
                    },
                    mini = {
                        enabled = true,
                    },
                    native_lsp = {
                        enabled = true,
                    },
                },
                color_overrides = {
                    mocha = {
                        base = "#1e1e2e",
                        mantle = "#181825",
                        crust = "#11111b",
                    },
                },
            })
            ColorMyPencils()
        end
    },


}
