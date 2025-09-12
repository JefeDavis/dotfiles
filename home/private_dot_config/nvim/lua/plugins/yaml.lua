local Util = require("lazyvim.util")

return {
	-- add yaml specific modules to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "yaml" })
			end
		end,
	},

	{
		"cwrau/yaml-schema-detect.nvim",
		---@module "yaml-schema-detect"
		---@type YamlSchemaDetectOptions
		opts = {}, -- use default options
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		ft = { "yaml" },
	},
	-- correctly setup lspconfig
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"b0o/SchemaStore.nvim",
			lazy = true,
			version = false, -- last release is way too old
		},
		opts = {
			-- make sure mason installs the server
			servers = {
				yamlls = {
					-- Have to add this for yamlls to understand that we support line folding
					capabilities = {
						textDocument = {
							foldingRange = {
								dynamicRegistration = false,
								lineFoldingOnly = true,
							},
						},
					},
					-- lazy-load schemastore when needed
					on_new_config = function(new_config)
						new_config.settings.yaml.schemas = vim.tbl_deep_extend(
							"force",
							new_config.settings.yaml.schemas or {},
							require("schemastore").yaml.schemas()
						)
					end,
					settings = {
						redhat = { telemetry = { enabled = false } },
						yaml = {
							keyOrdering = false,
							format = {
								enable = true,
							},
							validate = true,
							hover = true,
							completion = true,
							schemaStore = {
								-- Must disable built-in schemaStore support to use
								-- schemas from SchemaStore.nvim plugin
								enable = false,
								-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
								url = "",
							},
							schemas = {
								["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
								["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
								["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
								["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
								["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
								["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
								["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
								["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
								["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
								["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
								["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
								["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
								["https://schemas.gamewarden.io/schemas/helm/helminator.json"] = "{base,dev,stg,prod}-values.yaml",
								kubernetes = "*.yaml",
							},
						},
					},
				},
			},
			setup = {
				yamlls = function()
					-- Neovim < 0.10 does not have dynamic registration for formatting
					if vim.fn.has("nvim-0.10") == 0 then
						require("lazyvim.util").lsp.on_attach(function(client, bufnr)
							if client.name == "yamlls" and vim.bo.filetype == "helm" then
								vim.lsp.stop_client(bufnr, client.id)
							end
							if client.name == "yamlls" then
								client.server_capabilities.documentFormattingProvider = true
							end
						end)
					end
				end,
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		ft = "yaml",
		keys = {
			{ "<leader>cs", "<CMD>Telescope yaml_schema<CR>", desc = "Set Yaml Schema" },
		},
	},
}
