local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end

telescope.setup({
    extensions = {
        -- TODO: default options, could remove
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
})

telescope.load_extension("fzf")
