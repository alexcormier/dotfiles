-- bootstrap packer
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])
if not packer_exists then
    local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
    vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
end

return require("packer").startup({
    function()
        use({ "wbthomason/packer.nvim", opt = true })

        use({
            "nvim-telescope/telescope.nvim",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-lua/popup.nvim",
                { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            },
        })

        -- lsp
        use("neovim/nvim-lspconfig")
        use("williamboman/nvim-lsp-installer")
        use("tamago324/nlsp-settings.nvim")

        -- completion
        use({
            "hrsh7th/nvim-cmp",
            requires = {
                -- sources
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                -- snippets
                { "saadparwaiz1/cmp_luasnip", requires = "L3MON4D3/LuaSnip" }, -- TODO: replace with vsnip or ultisnip?
                -- icons for item kinds in completion menu
                "onsails/lspkind-nvim",
            }
        })

        -- treesitter and stuff
        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            requires = {
                "nvim-treesitter/nvim-treesitter-textobjects",
                "JoosepAlviste/nvim-ts-context-commentstring",
            },
        })

        use({
            "numToStr/Comment.nvim",
            requires = {"JoosepAlviste/nvim-ts-context-commentstring"},
        })

        -- themes
        -- use("navarasu/onedark.nvim")
        -- use({ "dracula/vim", as = "dracula" })
        use("folke/tokyonight.nvim")
    end,
    config = {
        compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
        display = {
            open_fn = require("packer.util").float,
        },
    },
})
