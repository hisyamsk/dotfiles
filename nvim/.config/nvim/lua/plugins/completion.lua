require('lazydev').setup {
  library = {
    -- Load luvit types when the `vim.uv` word is found
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}

-- Set up on first use to keep startup fast
vim.api.nvim_create_autocmd('InsertEnter', {
  once = true,
  callback = function()
    require('blink.cmp').setup {
      keymap = {
        preset = 'enter', -- <CR> accept, <C-Space> show, <C-n>/<C-p> select
        ['<C-l>'] = { 'snippet_forward', 'fallback' },
        ['<C-h>'] = { 'snippet_backward', 'fallback' },
      },
      completion = {
        list = { selection = { preselect = true, auto_insert = false } },
        menu = { border = 'rounded' },
        documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = 'rounded' } },
      },
      signature = { enabled = true, window = { border = 'rounded' } },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets' },
        providers = {
          lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },
      cmdline = { enabled = false },
    }
  end,
})
