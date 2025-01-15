return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      styles = {
        functions = { italic = false },
        keywords = { italic = false },
        sidebars = "transparent",
        floats = "transparent",
      },
      -- override some colors with our own
      on_colors = function(colors)
        local util = require("tokyonight.util")
        colors.fg = "#abb2bf"
        colors.bg = "#1e222a"
        colors.green = "#7da869"
        colors.bg_dark = "#1b1f27"
        colors.bg_float = colors.bg_dark
        colors.bg_highlight = util.blend_bg(colors.fg, 0.1, colors.bg)
        colors.bg_visual = colors.bg_highlight
        colors.bg_statusline = colors.bg
        colors.blue = "#519fdf"
        colors.comment = "#545862"
        colors.border = util.blend_bg(colors.fg, 0.7, colors.bg)
        -- borders
        colors.border_highlight = util.blend_bg(colors.fg, 0.75, colors.bg)
      end,
      -- override some hl group
      on_highlights = function(hl, c)
        local util = require("tokyonight.util")
        -- indent line
        hl.SnacksIndent.fg = util.blend_bg(c.fg_gutter, 0.1, c.bg)
        hl.SnacksIndentScope.fg = util.blend_bg(c.fg, 0.2, c.bg)
        -- selected words
        hl.LspReferenceText = { underline = true }
        hl.LspReferenceRead = { underline = true }
        hl.LspReferenceWrite = { underline = true }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      indent = {
        enabled = true,
        animate = {
          enabled = true,
          style = "out",
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = {
          border = "rounded",
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    -- use a function to override and not merge
    -- see https://lazyvim-ambitious-devs.phillips.codes/course/chapter-19/#_modifying_options_in_place
    -- if needed
    opts = {
      completion = {
        menu = {
          border = "rounded",
        },
        documentation = {
          window = {
            border = "rounded",
          },
        },
        ghost_text = {
          enabled = true,
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    opts = function(_, opts)
      opts.winopts = {
        preview = {
          vertical = "up:75%",
          layout = "vertical",
        },
      }
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "|", right = "|" },
        cons_enabled = true,
        theme = "tokyonight",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      popup_border_style = "rounded",
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 1, -- extra padding on left hand side
          -- indent guides
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
          -- expander config, needed for nesting files
          with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        modified = {
          symbol = "◎",
          highlight = "NeoTreeModified",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = "NeoTreeFileName",
        },
        git_status = {
          symbols = {
            -- Change type
            added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "✖", -- this can only be used in the git_status source
            renamed = "", -- this can only be used in the git_status source
            -- Status type
            untracked = "",
            ignored = "◌",
            unstaged = "○",
            staged = "●",
            conflict = "",
          },
        },
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        offsets = {
          {
            filetype = "neo-tree",
            -- to remove the Neo-tree title
            --text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
  {
    "snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          -- change the logo
          header = [[¯\_(ツ)_/¯]],
        },
      },
    },
  },
  -- diable inlay hint by default
  {
    "nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
  -- golang lsp config
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = false,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
      },
    },
    -- use a config for markdown lint
    {
      "mfussenegger/nvim-lint",
      opts = {
        linters = {
          ["markdownlint-cli2"] = {
            args = { "--config", "~/.markdownlint-cli2.yaml", "--" },
          },
        },
      },
    },
  },
}
