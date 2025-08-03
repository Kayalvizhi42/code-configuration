return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      -- Conditionally set the message based on `vim.g.remote_neovim_host`
      local remote_status = vim.g.remote_neovim_host and ("Remote: %s"):format(vim.uv.os_gethostname()) or ""

      -- Insert both the emoji and remote status into lualine_x
      table.insert(opts.sections.lualine_x, "😄")
      if remote_status ~= "" then
        table.insert(opts.sections.lualine_x, remote_status)
      end

      -- Add the loading component to lualine_x
      local M = require("lualine.component"):extend()

      M.processing = false
      M.spinner_index = 1

      local spinner_symbols = {
        "⠋",
        "⠙",
        "⠹",
        "⠸",
        "⠼",
        "⠴",
        "⠦",
        "⠧",
        "⠇",
        "⠏",
      }
      local spinner_symbols_len = 10

      -- Initializer
      function M:init(options)
        M.super.init(self, options)

        local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

        vim.api.nvim_create_autocmd({ "User" }, {
          pattern = "CodeCompanionRequest*",
          group = group,
          callback = function(request)
            if request.match == "CodeCompanionRequestStarted" then
              self.processing = true
            elseif request.match == "CodeCompanionRequestFinished" then
              self.processing = false
            end
          end,
        })
      end

      -- Function that runs every time statusline is updated
      function M:update_status()
        if self.processing then
          self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
          return spinner_symbols[self.spinner_index]
        else
          return nil
        end
      end

      table.insert(opts.sections.lualine_x, M)

      -- Define helper functions for CodeCompanion
      local function codecompanion_adapter_name()
        local chat = require("codecompanion").buf_get_chat(vim.api.nvim_get_current_buf())
        if not chat then
          return nil
        end

        return " " .. chat.adapter.formatted_name
      end

      local function codecompanion_current_model_name()
        local chat = require("codecompanion").buf_get_chat(vim.api.nvim_get_current_buf())
        if not chat then
          return nil
        end

        return chat.settings.model
      end

      -- Add CodeCompanion configuration
      table.insert(opts.sections.lualine_a, {
        filetypes = { "codecompanion" },
        sections = {
          lualine_a = {
            "mode",
          },
          lualine_b = {
            codecompanion_adapter_name,
          },
          lualine_c = {
            codecompanion_current_model_name,
          },
          lualine_x = {},
          lualine_y = {
            "progress",
          },
          lualine_z = {
            "location",
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {
            codecompanion_adapter_name,
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {
            "progress",
          },
          lualine_z = {},
        },
      })
    end,
    padding = { right = 1, left = 1, bottom = 5 },
  },
}
