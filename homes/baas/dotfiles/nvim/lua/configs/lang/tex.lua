vim.lsp.enable "texlab"

--- @type NvPluginSpec
return {
  {
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    config = function()
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_method = vim.fn.executable "pplatex" == 1 and "pplatex" or "latexlog"
      vim.g.vimtex_mappings_enabled = 0

      vim.g.vimtex_compiler_latexmk_engines = {
        _ = "-xelatex",
      }
    end,
    keys = {
      { "<leader>l", "", desc = "+vimtex", ft = "tex" },
      { "<leader>lc", "<Plug>(vimtex-compile)", desc = "Tex Compile", mode = { "n", "x" }, ft = "tex" },
      { "<leader>lq", "<Plug>(vimtex-view)", desc = "Tex View", mode = { "n", "x" }, ft = "tex" },
      { "<leader>lt", "<Plug>(vimtex-toc-toggle)", desc = "Tex Toggle TOC", mode = { "n", "x" }, ft = "tex" },
      { "<leader>lT", "<Plug>(vimtex-toc-focus)", desc = "Tex Focus TOC", mode = { "n", "x" }, ft = "tex" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.highlight = opts.highlight or {}
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "bibtex" })
      end
      if type(opts.highlight.disable) == "table" then
        vim.list_extend(opts.highlight.disable, { "latex" })
      else
        opts.highlight.disable = { "latex" }
      end
    end,
  },
  {
    "williamboman/mason-lspconfig",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "texlab" })
    end,
  },
}
