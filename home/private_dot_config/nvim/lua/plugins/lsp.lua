return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		{
			"j-hui/fidget.nvim",
			tag = "v1.2.0",
			config = function()
				require("fidget").setup({
					progress = {
						display = {
							progress_icon = { pattern = "dots", period = 1 },
							render_limit = 3,
						},
					},
				})
			end,
			opts = {},
		},
		{ "hrsh7th/cmp-nvim-lsp" },
	},
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})
		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(require("lsp.servers")),
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
					on_attach = require("mappings.lsp").on_attach,
					settings = require("lsp.servers")[server_name],
					filetypes = (require("lsp.servers")[server_name] or {}).filetypes,
				})
			end,
		})

		vim.diagnostic.config({
			title = false,
			underline = true,
			virtual_text = true,
			signs = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				source = "always",
				style = "minimal",
				header = "",
				prefix = "",
			},
		})

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end
	end,
}
