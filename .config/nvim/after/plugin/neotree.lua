-- Neo tree
require("neo-tree").setup({
  close_if_last_window = false,
  enable_diagnostics = true,
  enable_git_status = true,
  popup_border_style = "rounded",
  sort_case_insensitive = false,
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
    },
  },
  window = { width = 30 },
  default_component_configs = {
    indent ={
      with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "󰅂",
      expander_expanded = "󰅀",
      expander_highlight = "NeoTreeExpander",
    },
    git_status = {
      symbols = {
        -- Status type
        untracked = "",
        ignored   = "",
        unstaged  = "",
        modified  = "󰤌",
        staged    = "",
        conflict  = "",
      }
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
  },
  source_selector = {
    winbar = true,
    statusline = true
  }
})

