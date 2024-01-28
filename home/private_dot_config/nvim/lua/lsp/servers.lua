return {
  bashls = {
    filetypes = { "sh", "zsh", "bash" },
  },

  dockerls = {
    filetypes = { "dockerfile" }
  },

  docker_compose_language_service = {
    filetypes = { "yaml.docker-compose" }
  },

  lua_ls = {
    settings = {
      Lua = {
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
        telemetry = { enable = false },
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  },

  golangci_lint_ls = {
    filetypes = { "go", "gomod" }
  },

  gopls = {
    filetypes = { "go", "gomod", "gotmpl", "gowork" }
  },

  helm_ls = {
    filetypes = { "helm" }
  },

  jsonls = {
    filetypes = { "json", "jsonc" }
  },

  marksman = {
    filetypes = { "markdown", "markdown.mdx" }
  },

  rust_analyzer = {
    filetypes = { "rust" },
  },

  terraformls = {
    filetypes = { "terraform", "terraform-vars" }
  },

  vimls = {
    filetypes = { "vim" },
  },

  yamlls = {
    filetypes = { "yaml" }
  }
}
