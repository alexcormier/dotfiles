local ok, comment = pcall(require, "Comment")
if not ok then
    return
end

comment.setup({
    toggler = {
        line = "<leader>//",
        block = "<leader>**",
    },
    opleader = {
        line = "<leader>/",
        block = "<leader>*",
    },
    extra = {
        above = "<leader>/O",
        below = "<leader>/o",
        eol = "<leader>/A",
    },
    pre_hook = function(ctx)
        -- support mixed-language files
        local U = require("Comment.utils")
        local location = nil
        if ctx.ctype == U.ctype.block then
            location = require('ts_context_commentstring.utils').get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require('ts_context_commentstring.utils').get_visual_start_location()
        end

        return require('ts_context_commentstring.internal').calculate_commentstring {
            key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
            location = location,
        }
    end,
})

-- also use <C-/> to toggle comments
vim.api.nvim_set_keymap("i", "<C-_>", [[<cmd>lua require("Comment").toggle()<cr>]], {})
vim.api.nvim_set_keymap("n", "<C-_>", "<leader>//", {})
vim.api.nvim_set_keymap("v", "<C-_>", "<leader>/", {})
