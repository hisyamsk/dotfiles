---------------------------------
-- Language servers
---------------------------------
local lspconfig = require("lspconfig")
local caps = vim.lsp.protocol.make_client_capabilities()

local no_format = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider= false

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
end

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Capabilities
caps.textDocument.completion.completionItem.snippetSupport = true

-- JavaScript/Typescript
lspconfig.tsserver.setup({
  capabilities = caps,
  on_attach = no_format
})

-- ESLint
lspconfig.eslint.setup({
  capabilities = caps,
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll"
    })
  end,
})

-- docker
lspconfig.dockerls.setup({
  capabilities = caps,
  on_attach = no_format
})

-- Go
lspconfig.gopls.setup({
  capabilities = caps,
  on_attach = no_format,
  settings = {
    gopls = {
      buildFlags = {"-tags=wireinject,integration"}
    }
  }
})

-- golangci-lint
lspconfig.golangci_lint_ls.setup({
  capabilities = caps,
  on_attach = no_format
})

-- Lua
lspconfig.lua_ls.setup({
  capabilities = caps,
  on_attach = no_format
})

-- sql
lspconfig.sqlls.setup({
  capabilities = caps,
  on_attach = no_format
})

-- CSS 
lspconfig.cssls.setup {
  capabilities = caps,
  on_attach = no_format
}

-- Markdown
lspconfig.marksman.setup({
  capabilities = caps,
  on_attach = no_format
})

-- bash
lspconfig.bashls.setup({
  capabilities = caps,
  on_attach = no_format
})

lspconfig.pyright.setup({
  capabilities = caps,
})
-- Emmet
lspconfig.emmet_ls.setup({
  capabilities = snip_caps,
  filetypes = {
    "css",
    "html",
    "gohtml",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "typescript",
    "typescriptreact",
  },
})

lspconfig.rust_analyzer.setup({
  capabilities = caps,
  on_attach = no_format
})

