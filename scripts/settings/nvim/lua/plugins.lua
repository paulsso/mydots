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
    require("gitsigns").setup {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Next Hunk" })

        map("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Prev Hunk" })

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
        map("v", "<leader>hs", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end, { desc = "Stage Hunk" })
        map("v", "<leader>hr", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end, { desc = "Reset Hunk" })

        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
        map("n", "<leader>hb", gs.blame_line, { desc = "Blame Line" })

        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Line Blame" })
      end,
    }
  end,
  },
  {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
	dependencies = {
		"nvim-neotest/nvim-nio",
	}
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
