return {
  'sainnhe/gruvbox-material',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    vim.g.gruvbox_material_background = 'hard';
    vim.cmd.colorscheme 'gruvbox-material'
  end,
}
