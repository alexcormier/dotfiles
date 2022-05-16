if not pcall(require, "nvim-treesitter") then
    return
end

require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    indent = {
        enable = true,
    },

    -- modules from plugins

    textobjects = {
        select = {
            enable = true,
            lookahead = false, -- don't jump to start of selection
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
                ["ap"] = "@parameter.outer",
                ["ip"] = "@parameter.inner",
                ["as"] = "@statement.outer",
                ["a/"] = "@comment.outer",
            },
        },
    },

    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
})
