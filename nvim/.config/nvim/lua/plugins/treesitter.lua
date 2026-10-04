local ts = require 'nvim-treesitter'

local ensure_installed = { 'bash', 'go', 'c', 'sql', 'json', 'html', 'lua', 'markdown', 'vim', 'vimdoc' }
local missing = vim.tbl_filter(function(lang)
  return not vim.list_contains(ts.get_installed(), lang)
end, ensure_installed)
if #missing > 0 then
  ts.install(missing)
end

local function start(buf, lang)
  if vim.api.nvim_buf_is_valid(buf) and pcall(vim.treesitter.start, buf, lang) then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

-- Highlight + indent, auto-installing parsers for new languages
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(ev.match)
    if not lang then
      return
    end
    if vim.list_contains(ts.get_installed(), lang) then
      start(ev.buf, lang)
    elseif vim.list_contains(ts.get_available(), lang) then
      ts.install(lang):await(vim.schedule_wrap(function()
        start(ev.buf, lang)
      end))
    end
  end,
})
