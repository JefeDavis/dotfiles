local M = {}

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(
            sign.name,
            { texthl = sign.name, text = sign.text, numhl = "" }
        )
    end

    local config = {
        virtual_text = true,
        signs = false,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = 'rounded' }
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = 'rounded' }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = 'rounded' }
    )

    local lspconfig_window = require("lspconfig.ui.windows")
    local old_defaults = lspconfig_window.default_opts

    function lspconfig_window.default_opts(opts)
        local win_opts = old_defaults(opts)
        win_opts.border = 'rounded'
        return win_opts
    end
end

local definition_in_split = function()
  vim.api.nvim_command('vsp')
  vim.lsp.buf.definition()
  vim.api.nvim_command('normal zz')
end

local function lsp_keymaps(bufnr)
    local telescope = require("telescope.builtin")
    local opts_keymap = { buffer = bufnr, noremap = true, silent = true }

    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, opts_keymap)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts_keymap)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts_keymap)
    vim.keymap.set("n", "<CR>", vim.lsp.buf.definition, opts_keymap)
    vim.keymap.set("n", "<leader><CR>", definition_in_split, opts_keymap)
    vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, opts_keymap)
    vim.keymap.set("n", "<leader>li", vim.diagnostic.setloclist, opts_keymap)
    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.formatting, opts_keymap)
    vim.keymap.set("n", "<leader>l=", vim.lsp.diagnostic.show_line_diagnostics, opts_keymap)
    vim.keymap.set("n", "<leader>lO", "<CMD>Vista!!<CR>", opts_keymap)
    vim.keymap.set("n", "<leader>l?", "<CMD>LspInfo<CR>", opts_keymap)
    vim.keymap.set("n", "<leader>lr", "<CMD>LspRestart<CR>", opts_keymap)
    vim.keymap.set("n", "<leader>lwl", "<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts_keymap)
    vim.keymap.set("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, opts_keymap)
    vim.keymap.set("n", "<leader>lwd", vim.lsp.buf.remove_workspace_folder, opts_keymap)
    vim.keymap.set("n", "<leader>lc", vim.lsp.buf.code_action, opts_keymap)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts_keymap)
    vim.keymap.set("n", "go", telescope.lsp_document_symbols, opts_keymap)
    vim.keymap.set("n", "gd", telescope.lsp_definitions, opts_keymap)
    vim.keymap.set("n", "gt", telescope.lsp_type_definitions, opts_keymap)
    vim.keymap.set("n", "gr", telescope.lsp_references, opts_keymap)
    vim.keymap.set("n", "gi", telescope.lsp_implementations, opts_keymap)
    vim.keymap.set("n", "gR", vim.lsp.buf.rename, opts_keymap)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts_keymap)
end

local function lsp_highlight_document(client)
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_create_augroup("lsp_document_highlight", {})
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = "lsp_document_highlight",
            buffer = 0,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = "lsp_document_highlight",
            buffer = 0,
            callback = vim.lsp.buf.clear_references,
        })
    end
end

M.on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if not status_ok then
    return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
