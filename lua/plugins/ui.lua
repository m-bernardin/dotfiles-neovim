return {
  -- #dashboard managers

  -- ##alpha-nvim (!enabled)
  {
    "goolord/alpha-nvim",
    -- dependencies = { 'nvim-mini/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require("alpha.themes.dashboard")
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      startify.file_icons.provider = "devicons"
      require("alpha").setup(
        startify.config
      )
    end,
    enabled = false
  },

  -- ##dashboard-nvim (enabled)
  {
    "nvimdev/dashboard-nvim",
    event = 'VimEnter',
    config = function()
    require('dashboard').setup {
      theme = 'hyper',
      config = {
          header = {
            "",
            "  ` : | | | |:  ||  :     `  :  |  |+|: | : : :|   .        `              . ",
            "      ` : | :|  ||  |:  :    `  |  | :| : | : |:   |  .                    : ",
            "         .' ':  ||  |:  |  '       ` || | : | |: : |   .  `           .   :. ",
            "                `'  ||  |  ' |   *    ` : | | :| |*|  :   :               :| ",
            "        *    *       `  |  : :  |  .      ` ' :| | :| . : :         *   :.|| ",
            "             .`            | |  |  : .:|       ` | || | : |: |          | || ",
            "      '          .         + `  |  :  .: .         '| | : :| :    .   |:| || ",
            "         .                 .    ` *|  || :       `    | | :| | :      |:| |  ",
            " .                .          .        || |.: *          | || : :     :|||    ",
            "        .            .   . *    .   .  ` |||.  +        + '| |||  .  ||`     ",
            "     .             *              .     +:`|!             . ||||  :.||`      ",
            " +                      .                ..!|*          . | :`||+ |||`       ",
            "     .                         +      : |||`        .| :| | | |.| ||`     .  ",
            "       *     +   '               +  :|| |`     :.+. || || | |:`|| `          ",
            "                            .      .||` .    ..|| | |: '` `| | |`  +         ",
            "  .       +++                      ||        !|!: `       :| |               ",
            "              +         .      .    | .      `|||.:      .||    .      .    `",
            "          '                           `|.   .  `:|||   + ||'     `           ",
            "  __    +      *                         `'       `'|.    `:                 ",
            "\"'  `---\"\"\"----....____,..^---`^``----.,.___          `.    `.  .    ____,.,-",
            "    ___,--'\"\"`---\"'   ^  ^ ^        ^       \"\"\"'---,..___ __,..---\"\"'",
            "--\"'                           ^                         ``--..,__ D. Rice  ",
            "",
            -- ascii art source: https://www.asciiart.eu/art/6b3246c9058108ef
        },
        week_header = {
          enable = false,
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = ' Apps',
            group = 'DiagnosticHint',
            action = 'Telescope app',
            key = 'a',
          },
          {
            desc = ' dotfiles',
            group = 'Number',
            action = 'Telescope dotfiles',
            key = 'd',
          }
        }
      }
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },

  -- #line numbers
  {
    "zaakiy/line-justice.nvim",
    dependencies = { "luukvbaal/statuscol.nvim", "lewis6991/gitsigns.nvim" },
    lazy = false,
    config = function()
      local lj = require("line-justice")
      lj.setup()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        relculright = true,
        segments = {
          { text = { builtin.foldfunc },                                                      click = "v:lua.ScFa" },
          { sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 1, auto = true },   click = "v:lua.ScSa" },
          { sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },         click = "v:lua.ScSa" },
          { sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true }, click = "v:lua.ScSa" },
          { text = { lj.segment },                                                            click = "v:lua.ScLa" },
        },
      })
    end,
  },

  -- #notifications
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>sn", "", desc = "+noice"},
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<leader>snt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
    },
    config = function(_, opts)
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == "lazy" then
        vim.cmd([[messages clear]])
      end
      require("noice").setup(opts)
    end,
  },

  -- #statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup{
        options = {
					theme = 'auto',
      		component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          globalstatus = true,
        },
			  sections = {
				  lualine_a = {'mode'},
        	lualine_b = {'branch','diff'},
        	lualine_c = {'filename', "diagnostics"},
          lualine_x = {},
          lualine_y = {'filetype'},
        	lualine_z = {'location'},
      	},
      }
    end
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  }
}
