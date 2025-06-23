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
  {
	  "nvim-telescope/telescope.nvim",
	  dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
  "nvim-telescope/telescope-live-grep-args.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("telescope").load_extension("live_grep_args")
  end,
  },
  {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, for file icons
  config = function()
    require("nvim-tree").setup {}
    -- Keybinding to toggle file browser
    vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
  end,
  },
  {
  "nvim-pack/nvim-spectre",
  config = function()
    vim.keymap.set("n", "<C-S-F>", function()
      require("spectre").toggle()
    end, { desc = "Toggle Spectre (Search & Replace)", noremap = true, silent = true })
  end,
 },
 {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup()
  end,
  },
  {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()
    -- Automatically open dapui when starting debugger
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    -- Automatically close dapui when ending debugger
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
  }
}
