return {
    "greggh/claude-code.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>ccv", desc = "Toggle Claude Code (vertical)" },
        { "<leader>cch", desc = "Toggle Claude Code (horizontal)" },
    },
    config = function()
        local claude = require("claude-code")
        claude.setup({
            window = {
                position = "rightbelow vsplit",
                split_ratio = 0.4,
                enter_insert = true,
                hide_numbers = true,
                hide_signcolumn = true,
            },
            refresh = {
                enable = true,
            },
            git = {
                use_git_root = true,
            },
            keymaps = {
                toggle = {
                    normal = false,
                    terminal = "<C-\\>",
                },
            },
        })

        local function toggle_with_position(position, ratio)
            return function()
                claude.config.window.position = position
                claude.config.window.split_ratio = ratio
                claude.toggle()
            end
        end

        vim.keymap.set("n", "<leader>ccv", toggle_with_position("rightbelow vsplit", 0.4),
            { desc = "Toggle Claude Code (vertical)" })
        vim.keymap.set("n", "<leader>cch", toggle_with_position("botright", 0.3),
            { desc = "Toggle Claude Code (horizontal)" })
    end,
}
