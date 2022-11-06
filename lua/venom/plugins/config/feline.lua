-- TODO: Complete feline

local feline_ok, feline = pcall(require, "feline")
if not feline_ok then return end

local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')
-- local gps = require("nvim-gps")

local function lsp_clients()
  local buf_clients = vim.lsp.buf_get_clients()
  if next(buf_clients) == nil then
    return ""
  end
  local buf_client_names = {}
  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end
  return "[" .. table.concat(buf_client_names, ", ") .. "]"
end

local function lsp_progress()
  -- if not is_active then
  -- 	return
  -- end
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return ""
  end
  local status = {}
  for _, msg in pairs(messages) do
    local title = ""
    if msg.title then
      title = msg.title
    end
    table.insert(status, (msg.percentage or 0) .. "%% " .. title)
  end
  local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, "  ") .. " " .. spinners[frame + 1]
end

vim.api.nvim_set_hl(0, "MiniStatuslineLspClient", { fg = "#a9a1e1" })

local function status_line()
  local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
  local git = MiniStatusline.section_git({ trunc_width = 75 })
  local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
  local clients = lsp_clients()
  local progress = lsp_progress()
  local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
  local location = MiniStatusline.section_location({ trunc_width = 75 })
  return MiniStatusline.combine_groups({
    { hl = mode_hl, strings = { mode } },
    { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
    "%<",
    { hl = "MiniStatuslineLspClient", strings = { clients } },
    { hl = "MiniStatuslineLspClient", strings = { progress } },
    "%=",
    { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
    { hl = mode_hl, strings = { location } },
  })
end

local force_inactive = {
  filetypes = {},
  buftypes = {},
  bufnames = {}
}

local winbar_components = {
  active = { {}, {}, {} },
  inactive = { {}, {}, {} },
}

local components = {
  active = { {}, {}, {} },
  inactive = { {}, {}, {} },
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local checkwidth = function()
  local squeeze_width = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

-- Insert three sections (left, mid and right) for the active statusline
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})

-- Insert two sections (left and right) for the inactive statusline
table.insert(components.inactive, {})
table.insert(components.inactive, {})

-- Insert a component that will be on the left side of the statusline
-- when the window is active:
table.insert(components.active[1], {
  -- Component info here
})

-- Insert another component that will be on the left side of the statusline
-- when the window is active:
table.insert(components.active[1], {
  -- Component info here
})

-- Insert a component that will be in the middle of the statusline
-- when the window is active:
table.insert(components.active[2], {
  -- Component info here
})

-- Insert a component that will be on the right side of the statusline
-- when the window is active:
table.insert(components.active[3], {
  -- Component info here
})

-- Insert a component that will be on the left side of the statusline
-- when the window is inactive:
table.insert(components.inactive[1], {
  -- Component info here
})

-- Insert a component that will be on the right side of the statusline
-- when the window is inactive:
table.insert(components.inactive[2], {
  -- Component info here
})

local components = {
  active = {
    left,
    middle,
    right,
  },
  inactive = {
    left,
    middle,
    right,
  },
}


feline.setup({
  components = components,
  theme = one_monokai,
  vi_mode_colors = vi_mode_colors,
})
