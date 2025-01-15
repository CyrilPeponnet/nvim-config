return {
  -- windows picker to use in Neo-tree when pressing w
  {
    "s1n7ax/nvim-window-picker",
    version = "2.*",
    config = function()
      require("window-picker").setup({
        hint = "floating-big-letter",
        autoselect_one = true,
        include_current_win = false,
        use_winbar = "smart",
        filter_rules = {
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify", "neotest-summary", "neo-tree-git" },

            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal", "quickfix", "help", "nofile" },
          },
        },
        highlights = {
          winbar = {
            focused = {
              fg = "#ededed",
              bg = "#4f76e3",
              bold = true,
            },
            unfocused = {
              fg = "#ededed",
              bg = "#4f76e3",
              bold = true,
            },
          },
        },
      })
    end,
  },
  -- use own color picker diable TW integration
  {
    "echasnovski/mini.hipatterns",
    opts = function(_, opts)
      opts.highlighters = {}
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = false, -- "Name" codes like Blue or blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = true, -- 0xAARRGGBB hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "virtualtext", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = true, -- Enable tailwind colors
          virtualtext = "■■■■■■",
        },
      })
    end,
  },
}
