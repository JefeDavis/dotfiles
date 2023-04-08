local capabilities = require 'lsp_capabilities'()

vim.opt_local.cursorcolumn = true
vim.b.undo_plugin = '|setlocal cursorcolumn<'

local executable = 'yaml-language-server'
local root_files = {
  ".git"
}

if vim.fn.executable(executable) then
  vim.lsp.start({
    name = 'yamlls',
    cmd = { executable, "--stdio" },
    root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
    capabilities = capabilities,
    settings = {
      yaml = {
        schemaStore = {
          enable = true,
          url = "https://www.schemastore.org/api/json/catalog.json",
        },
        schemas = {
          kubernetes = "*.yaml",
          ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
          ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
          ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-pipelines.yml",
          ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
          ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
          ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
          ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
          ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
          ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
          ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
          ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
          ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
          ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
        },
        format = { enabled = false },
        -- anabling this conflicts between Kubernetes resources and kustomization.yaml and Helmreleases
        -- see utils.custom_lsp_attach() for the workaround
        -- how can I detect Kubernetes ONLY yaml files? (no CRDs, Helmreleases, etc.)
        validate = false,
        completion = true,
        hover = true,
      }
    }
  })
end
