---@type LazySpec
return {

  -- codecompanion extensions
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      --other plugins
      "ravitemer/codecompanion-history.nvim",
    },
  },

  {
    "Davidyz/VectorCode",
    version = "<0.7.0", -- optional, depending on whether you're on nightly or release
    dependencies = { "nvim-lua/plenary.nvim" },
    build = "uv tool upgrade vectorcode",
    cmd = "VectorCode", -- if you're lazy-loading VectorCode
  },

  -- codecompanion
  {
    "olimorris/codecompanion.nvim",
    opts = {
      strategies = {
        chat = {
          adapter = "openai",
          keymaps = {
            next_chat = {
              modes = {
                n = "+",
              },
              index = 11,
              callback = "keymaps.next_chat",
              description = "Next Chat",
            },
            previous_chat = {
              modes = {
                n = "_",
              },
              index = 12,
              callback = "keymaps.previous_chat",
              description = "Previous Chat",
            },
          },
        },
        inline = {
          adapter = "openai",
        },
        cmd = {
          adapter = "openai",
        },
      },
      adapters = {
        opts = {
          allow_insecure = true,
          proxy = os.getenv "OPENAI_HTTP_PROXY" or "",
        },
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = os.getenv "OPENAI_API_KEY",
            },
            schema = {
              model = {
                default = "gpt-4.1",
              },
            },
          })
        end,
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            -- Keymap to open history from chat buffer (default: gh)
            keymap = "gh",
            -- Keymap to save the current chat manually (when auto_save is disabled)
            save_chat_keymap = "sc",
            -- Save all chats by default (disable to save only manually using 'sc')
            auto_save = true,
            -- Number of days after which chats are automatically deleted (0 to disable)
            expiration_days = 0,
            -- Picker interface (auto resolved to a valid picker)
            picker = "telescope", --- ("telescope", "snacks", "fzf-lua", or "default")
            -- Customize picker keymaps (optional)
            picker_keymaps = {
              rename = { n = "r", i = "<M-r>" },
              delete = { n = "d", i = "<M-d>" },
              duplicate = { n = "<C-y>", i = "<C-y>" },
            },
            ---Automatically generate titles for new chats
            auto_generate_title = true,
            title_generation_opts = {
              ---Adapter for generating titles (defaults to current chat adapter)
              adapter = nil, -- "copilot"
              ---Model for generating titles (defaults to current chat model)
              model = nil, -- "gpt-4o"
              ---Number of user prompts after which to refresh the title (0 to disable)
              refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
              ---Maximum number of times to refresh the title (default: 3)
              max_refreshes = 3,
            },
            ---On exiting and entering neovim, loads the last chat on opening chat
            continue_last_chat = false,
            ---When chat is cleared with `gx` delete the chat from history
            delete_on_clearing_chat = false,
            ---Directory path to save the chats
            dir_to_save = vim.fn.stdpath "data" .. "/codecompanion-history",
            ---Enable detailed logging for history extension
            enable_logging = false,
            ---Optional filter function to control which chats are shown when browsing
            chat_filter = nil, -- function(chat_data) return boolean end
          },
        },

        vectorcode = {
          opts = {
            add_tool = true,
            add_slash_command = true,
            ---@type VectorCode.CodeCompanion.ToolOpts
            tool_opts = {
              max_num = { chunk = -1, document = -1 },
              default_num = { chunk = 50, document = 10 },
              include_stderr = false,
              use_lsp = false,
              auto_submit = { ls = false, query = false },
              ls_on_start = false,
              no_duplicate = true,
              chunk_mode = false,
            },
          },
        },
      },
      prompt_library = {
        ["Project Coordinator"] = {
          strategy = "chat",
          description = "Координирует задачи между ИИ‑агентами по вашему проекту",
          opts = {
            auto_submit = false,
            short_name = "coord",
            ignore_system_prompt = true,
          },
          prompts = {
            {
              role = "system",
              content = require "prompts.project_coordinator",
            },
            {
              role = "user",
              content = "Изучи документацию проекта над которым мы работаем для определения его сути.\n",
            },
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- other dependencies
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
}
