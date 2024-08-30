return {
	{ import = "lazyvim.plugins.extras.lang.docker" },
	{ import = "lazyvim.plugins.extras.lang.go" },
	{ import = "lazyvim.plugins.extras.lang.json" },
	{ import = "lazyvim.plugins.extras.lang.markdown" },
	{ import = "lazyvim.plugins.extras.lang.rust" },
	{ import = "lazyvim.plugins.extras.lang.terraform" },
	{ import = "lazyvim.plugins.extras.lang.yaml" },
	{
		"iamcco/markdown-preview.nvim",
		opts = function()
			vim.api.nvim_exec2(
				[[
        function! Open_preview_in_incognito_window(url)
          silent !clear
          execute "silent !open -n -a '/Applications/Google\ Chrome.app' --args -incognito " . a:url
        endfunction
        let g:mkdp_browserfunc = 'Open_preview_in_incognito_window'
      ]],
				{
					output = false,
				}
			)
		end,
	},
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		opts = {
			lang = {
				gitcommit = "; %s",
			},
		},
	},
}
