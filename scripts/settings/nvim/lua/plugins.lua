-- ~/.config/nvim/lua/plugins.lua

return {
  {
    "gbprod/nord.nvim",
    lazy = false,  -- Load immediately
    priority = 1000,
    config = function()
      vim.cmd("colorscheme nord")
    end,
  },
  -- You can add more plugins here
}
