local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
}


function M.config()
  local servers = {
    "bashls",
    "cssls",
    "html",
    "jdtls",
    "jsonls",
    "lemminx",
    "lua_ls",
    "pyright",
    "tsserver",
  }

  require("mason").setup {
    ui = {
      border = "rounded",
    },
  }

  require("mason-lspconfig").setup {
    ensure_installed = servers,
  }
end

return M
