return {
  -- Nord theme
  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme nord")
    end,
  },

  -- NvimTree (file browser)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup {}
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Spectre
  { "nvim-pack/nvim-spectre" },

  -- Git signs
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
          map("n", "]c", function() if vim.wo.diff then return "]c" end vim.schedule(gs.next_hunk) return "<Ignore>" end, { expr = true })
          map("n", "[c", function() if vim.wo.diff then return "[c" end vim.schedule(gs.prev_hunk) return "<Ignore>" end, { expr = true })
          map("n", "<leader>hs", gs.stage_hunk)
          map("n", "<leader>hr", gs.reset_hunk)
          map("v", "<leader>hs", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end)
          map("v", "<leader>hr", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end)
          map("n", "<leader>hp", gs.preview_hunk)
          map("n", "<leader>hb", gs.blame_line)
          map("n", "<leader>tb", gs.toggle_current_line_blame)
        end,
      }
    end,
  },

  -- DAP
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      -- Python
      lspconfig.pyright.setup {}
      -- C/C++
      lspconfig.clangd.setup {}
      -- Bash
      lspconfig.bashls.setup {}
      -- JSON
      lspconfig.jsonls.setup {}
      -- YAML
      lspconfig.yamlls.setup {}
      -- Lua
      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      }
    end,
  },

  -- Autocomplete
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      }
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        options = {
          theme = "nord",
          section_separators = "",
          component_separators = "",
        },
      }
    end,
  },
}
