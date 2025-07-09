return {
  -- Extensions for Telescope

  -- Telescope config
  {
    "nvim-telescope/telescope.nvim",

    keys = {
        {
            "<leader>j",
            "<cmd>Telescope jsonfly<cr>",
            desc = "Open json(fly)",
            ft = { "json", "xml", "yaml" },
            mode = "n"
        }
    },

    opts = {
      defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        -- mappings = {
        --   i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        -- ["<C-h>"] = "which_key",
        --   }
        -- }
        path_display = {
          filename_first = {
            reversed_directories = true,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--sortr=modified" },
          -- hidden = false,
          -- no_ignore = true,
        },
      },
      extensions = {
        -- Your extension configuration goes here:
        frecency = {
          matcher = "fuzzy",
        },
        -- please take a look at the readme of the extension you want to configure
      },
    },
  },
}
