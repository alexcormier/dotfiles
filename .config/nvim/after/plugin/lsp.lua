local ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not ok then
    return
end

local servers = {
    "bashls",
    "clangd",
    "cssls",
    "dockerls",
    "gopls",
    "html",
    "jdtls",
    "jsonls",
    "pyright",
    "rust_analyzer",
    "sqlls",
    "sumneko_lua",
    "tsserver",
    "vimls",
    "yamlls",
    "zls",
}

local lsp_installer_servers = require("nvim-lsp-installer.servers")
for _, server_name in ipairs(servers) do
    local ok, server = lsp_installer_servers.get_server(server_name)
    if ok and not server:is_installed() then
        print("installing " .. server.name)
        server:install()
    end
end

lsp_installer.on_server_ready(function(server) server:setup({
    on_attach = function(client, bufnr)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = bufnr })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
        vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })

        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })

        -- move to global keymap?
        vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { buffer = bufnr })
        vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { buffer = bufnr })

        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = bufnr })
    end,
}) end)
