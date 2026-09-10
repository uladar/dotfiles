local util = require('lspconfig.util')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.diagnostic.config({
  float = { border = 'rounded', source = 'if_many' },
  severity_sort = true,
  signs = true,
  underline = true,
  virtual_text = { spacing = 2, source = 'if_many' },
})

local servers = {
  ruby_lsp = {
    filetypes = { 'ruby' },
    cmd = { 'bundle', 'exec', 'ruby-lsp' },
    root_dir = util.root_pattern('Gemfile', '.git'),
    init_options = {
      formatter = 'rubocop',
      linters = { 'rubocop' },
      experimentalFeaturesEnabled = true,
    },
    executable = 'bundle',
  },
  ts_ls = {
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    cmd = { 'typescript-language-server', '--stdio' },
    root_dir = util.root_pattern('package.json', 'tsconfig.json', '.git'),
    executable = 'typescript-language-server',
  },
  gopls = {
    filetypes = { 'go', 'gomod', 'gowork' },
    cmd = { 'gopls' },
    root_dir = util.root_pattern('go.mod', 'go.work', '.git'),
    executable = 'gopls',
  },
  elixirls = {
    filetypes = { 'elixir', 'eelixir', 'heex' },
    cmd = { 'elixir-ls' },
    root_dir = util.root_pattern('mix.exs', '.git'),
    executable = 'elixir-ls',
  },
}

for name, server in pairs(servers) do
  vim.api.nvim_create_autocmd('FileType', {
    pattern = server.filetypes,
    callback = function(args)
      if vim.fn.executable(server.executable) ~= 1 then return end

      for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
        if client.name == name then return end
      end

      local root = server.root_dir(vim.api.nvim_buf_get_name(args.buf)) or vim.loop.cwd()
      vim.lsp.start({
        name = name,
        cmd = server.cmd,
        root_dir = root,
        capabilities = capabilities,
        init_options = server.init_options,
      })
    end,
  })
end
