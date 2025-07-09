return {

  {
    "mfussenegger/nvim-dap",
    init = function()
      dap = require "dap"
      dap.configurations.python = {
        {
          type = "python",
          justMyCode = false,
          request = "attach",
          name = "Attach to debugpy",
          connect = {
            host = "127.0.0.1",
            port = 5678, -- замените на нужный порт
          },
          mode = "remote",
          pathMappings = {
            {
              localRoot = vim.fn.getcwd(), -- локальный путь к коду
              remoteRoot = ".", -- корень на удалённой стороне
            },
          },
        },
      }
    end,
  },

  {
    "mfussenegger/nvim-dap-python",
    init = function()
      dap_python = require "dap-python"
      dap_python.setup "/home/danya/repos/lkorti/db-agents/.venv/bin/langgraph"
    end,
  },
}
