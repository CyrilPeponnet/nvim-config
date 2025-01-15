return {
  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.diff",
    },
    config = true,
    keys = {
      {
        "<leader>aa",
        "<cmd>CodeCompanionChat toggle<cr>",
        mode = { "n", "v" },
        desc = "Toggle the chat",
      },
      {
        "<leader>an",
        "<cmd>CodeCompanionChat<cr>",
        mode = { "n", "v" },
        desc = "Start a new chat",
      },
      {
        "<leader>ai",
        function()
          vim.ui.input({ prompt = "Prompt" }, function(new)
            vim.cmd("CodeCompanion /buffer " .. new)
          end)
        end,
        mode = { "n", "v" },
        desc = "Inline prompt",
      },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "anthropic",
          roles = {
            llm = "✨LLM ✨",
            user = "Prompt",
          },
        },
        inline = {
          adapter = "anthropic",
        },
      },
      display = {
        chat = {
          intro_message = "✨Make me dream ✨ (? for help)",
        },
        diff = {
          enabled = true,
          provider = "mini_diff", -- default|mini_diff
        },
      },
      opts = {
        system_prompt = [[You are an AI programming assistant.
You are currently plugged in to the Neovim text editor on a user's machine.

Your core tasks include:
- Answering general programming questions.
- Explaining how the code in a Neovim buffer works.
- Reviewing the selected code in a Neovim buffer.
- Generating unit tests for the selected code.
- Proposing fixes for problems in the selected code.
- Scaffolding code for a new workspace.
- Finding relevant code to the user's query.
- Proposing fixes for test failures.
- Answering questions about Neovim.
- Running tools.

You must:
- Follow the user's requirements carefully and to the letter.
- Keep your answers short and impersonal, especially if the user responds with context outside of your tasks.
- Minimize other prose.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of the Markdown code blocks.
- Avoid including line numbers in code blocks.
- Avoid wrapping the whole response in triple backticks.
- Only return code that's relevant to the task at hand. You may not need to return all of the code that the user has shared.
- Use actual line breaks instead of '\n' in your response to begin new lines.
- Use '\n' only when you want a literal backslash followed by a character 'n'.
- All non-code responses must be in English.

When given a task:
1. Think step-by-step and describe your plan for what to build in pseudocode, written out in great detail, unless asked not to do so.
2. Output the code in a single code block, being careful to only return relevant code.
3. You should always generate short suggestions for the next user turns that are relevant to the conversation.
4. You can only give one reply for each conversation turn.]],
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "ai", icon = "", mode = { "n", "v" } },
      },
    },
  },
  -- add codecompanion to the completion sources
  {
    "saghen/blink.cmp",
    dependencies = {
      "olimorris/codecompanion.nvim",
    },
    opts = function(_, opts)
      table.insert(opts.sources.default, "codecompanion")
    end,
  },
}
