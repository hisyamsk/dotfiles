-- Server configs come from nvim-lspconfig; overrides go through vim.lsp.config
local servers = {
  clangd = {},
  gopls = {},
  html = {},
  pyright = {},
  dockerls = {},
  rust_analyzer = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = 'Replace' },
      },
    },
  },
}
local tools = { 'stylua' }

vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities() })
for name, config in pairs(servers) do
  vim.lsp.config(name, config)
end

-- mason is slow to set up (~30ms), so do it right after startup.
-- vim.lsp.enable() also attaches to buffers that are already open.
vim.schedule(function()
  require('mason').setup()
  -- Installs the servers and enables them (vim.lsp.enable) once installed
  require('mason-lspconfig').setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_enable = { exclude = { 'stylua' } }, -- stylua runs through conform
  }

  local registry = require 'mason-registry'
  registry.refresh(function()
    for _, name in ipairs(tools) do
      local ok, pkg = pcall(registry.get_package, name)
      if ok and not pkg:is_installed() and not pkg:is_installing() then
        pkg:install()
      end
    end
  end)
end)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf
    local map = function(keys, func, desc)
      -- nowait: don't wait on nvim's default `grn`/`grr`/... when pressing `gr`
      vim.keymap.set('n', keys, func, { buffer = buf, desc = 'LSP: ' .. desc, nowait = true })
    end
    local lsp = function(scope)
      return function()
        MiniExtra.pickers.lsp { scope = scope }
      end
    end

    map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    map('gr', lsp 'references', '[G]oto [R]eferences')
    map('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    map('<leader>ds', lsp 'document_symbol', '[D]ocument [S]ymbols')
    map('<leader>ws', lsp 'workspace_symbol', '[W]orkspace [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    map('K', function()
      vim.lsp.buf.hover { border = 'rounded' }
    end, 'Hover Documentation')

    -- Highlight references of the word under the cursor
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', buf) then
      local group = vim.api.nvim_create_augroup('lsp-highlight-' .. buf, { clear = true })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, { buffer = buf, group = group, callback = vim.lsp.buf.document_highlight })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, { buffer = buf, group = group, callback = vim.lsp.buf.clear_references })
    end
  end,
})

-- Go: organize imports on save (formatting itself is done by conform)
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function(ev)
    local client = vim.lsp.get_clients({ bufnr = ev.buf, name = 'gopls' })[1]
    if not client then
      return
    end
    local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
    params.context = { only = { 'source.organizeImports' }, diagnostics = {} }
    local res = client:request_sync('textDocument/codeAction', params, 1000, ev.buf)
    for _, action in ipairs(res and res.result or {}) do
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
      end
    end
  end,
})
