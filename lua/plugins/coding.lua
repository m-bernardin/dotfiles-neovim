return {
  -- #completion engine
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = { "rafamadriz/friendly-snippets" },

    -- use a release tag to download pre-built binaries
    version = "1.*",
    -- AND/OR build from source
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = "super-tab" },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono"
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },

  -- #java language support
  {
    "nvim-java/nvim-java",
    config = function()
      require('java').setup()
      vim.lsp.enable('jdtls')
    end,
  },

  -- #csharp language tools
  {
   "iabdelkareem/csharp.nvim",
    dependencies = {
      "williamboman/mason.nvim", -- Required, automatically installs omnisharp
      "mfussenegger/nvim-dap",
      "Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
    },
    opts = {-- These are the default values
        lsp = {
          -- Sets if you want to use omnisharp as your LSP
          omnisharp = {
          -- When set to false, csharp.nvim won't launch omnisharp automatically.
            enable = true,
            -- When set, csharp.nvim won't install omnisharp automatically. Instead, the omnisharp instance in the cmd_path will be used.
            cmd_path = vim.fn.stdpath("data") .. "/mason/packages/omnisharp/OmniSharp",
            -- The default timeout when communicating with omnisharp
            default_timeout = 1000,
            -- Settings that'll be passed to the omnisharp server
            enable_editor_config_support = true,
            organize_imports = true,
            load_projects_on_demand = false,
            enable_analyzers_support = true,
            enable_import_completion = true,
            include_prerelease_sdks = true,
            analyze_open_documents_only = false,
            enable_package_auto_restore = true,
            -- Launches omnisharp in debug mode
            debug = false,
          },
          -- Sets if you want to use roslyn as your LSP
          roslyn = {
            -- When set to true, csharp.nvim will launch roslyn automatically.
            enable = false,
            -- Path to the roslyn LSP see 'Roslyn LSP Specific Prerequisites' above.
            cmd_path = nil,
          },
          -- The capabilities to pass to the omnisharp server
          capabilities = nil,
          -- on_attach function that'll be called when the LSP is attached to a buffer
          on_attach = nil
        },
      logging = {
        -- The minimum log level.
        level = "INFO",
      },
      dap = {
        -- When set, csharp.nvim won't launch install and debugger automatically. Instead, it'll use the debug adapter specified.
        --- @type string?
        adapter_name = nil,
      }
    },
    config = function (opts)
      require("mason").setup() -- Mason setup must run before csharp, only if you want to use omnisharp
      require("csharp").setup(opts)
    end,
  },
}
