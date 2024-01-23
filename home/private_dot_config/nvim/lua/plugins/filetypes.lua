return {
  {
    "ellisonleao/glow.nvim",
    config = function()
      require('glow').setup({
        style = "~/Library/preferences/glow/themes/mocha.json",
      })
    end,
    cmd = "Glow"
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    init = function()
      vim.api.nvim_exec([[
        function! Open_preview_in_incognito_window(url)
          silent !clear
          execute "silent !open -n -a '/Applications/Google\ Chrome.app' --args -incognito " . a:url
        endfunction

        let g:mkdp_browserfunc = 'Open_preview_in_incognito_window'
      ]], false)
    end
  }
}
