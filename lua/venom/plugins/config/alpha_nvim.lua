--https://manytools.org/hacker-tools/ascii-banner
--https://xflea.github.io/nv-dashboard-header-maker/

local alpha_ok, alpha = pcall(require, "alpha")
if not alpha_ok then return end

local dashboard_ok, dashboard = pcall(require, "alpha.themes.dashboard")
if not dashboard_ok then return end

-- local datetime_ok, datetime = pcall(os.date, "%I:%M:%p 🕔 %d-%m-%Y")
-- local version_ok, nvim_version = pcall(os.capture, "nvim --version | awk 'NR == 1'")

math.randomseed(os.time())
local function pick_color()
local colors = {"String", "Indentifier", "Keyword", "Number"}
  return colors[math.random(#colors)]
end

local handle = io.popen('fd -d 2 . $HOME"/.local/share/nvim/site/pack/packer" | head -n -2 | wc -l | tr -d "\n" ')
local plugins = handle:read("*a")
handle:close()

local thingy = io.popen('echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"')
local date = thingy:read("*a")
thingy:close()

local header = {
  type = "text",
  val = {
	  '',
	  ' █████   █████ ██████████ ██████   █████    ███████    ██████   ██████',
	  '░░███   ░░███ ░░███░░░░░█░░██████ ░░███   ███░░░░░███ ░░██████ ██████ ',
	  ' ░███    ░███  ░███  █ ░  ░███░███ ░███  ███     ░░███ ░███░█████░███ ',
	  ' ░███    ░███  ░██████    ░███░░███░███ ░███      ░███ ░███░░███ ░███ ',
	  ' ░░███   ███   ░███░░█    ░███ ░░██████ ░███      ░███ ░███ ░░░  ░███ ',
	  '  ░░░█████░    ░███ ░   █ ░███  ░░█████ ░░███     ███  ░███      ░███ ',
	  '    ░░███      ██████████ █████  ░░█████ ░░░███████░   █████     █████',
	  '     ░░░      ░░░░░░░░░░ ░░░░░    ░░░░░    ░░░░░░░    ░░░░░     ░░░░░ ',
	  '',
  },
  opts = {
    position = "center",
    -- hl = "AlphaHeader"
    hl = pick_color()
  }
}

local plugin_count = {
  type = "text",
  -- val = "└─   " .. plugins .. " plugins in total ─┘",
  val = {
    "└─   " .. plugins .. " plugins in total ─┘",
    "",
    "",
    "",
  },
  opts = {
    position = "center",
    hl = "AlphaHeader",
  }
}

local heading = {
  type = "text",
  -- val = "┌─   Today is " .. date .. " ─┐",
  val = { "",
    "┌─   Today is " .. date .. " ─┐",
  },
  opts = {
    position = "center",
    hl = "AlphaHeader",
  }
}

local footer = {
  type = "text",
  val = "~ Indeed Harship will be with ease ~",
  opts = {
    position = "center",
    hl = "AlphaFooter",
  }
}

local function button(sc, txt, keybind)
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

  local opts = {
    position = "center",
    text = txt,
    shortcut = sc,
    cursor = 5,
    width = 24,
    align_shortcut = "right",
    hl_shortcut = "AlphaHeader",
    hl = "AlphaHeader",
  }
  if keybind then
    opts.keymap = {"n", sc_, keybind, {noremap = true, silent = true}}
  end

  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = opts,
  }
end

local buttons = {
  type = "group",
  val = {
    -- button( "LDR h", "   Recents" , ":Telescope oldfiles<CR>"),
    -- button( "LDR y", "   Explore" , ":Telescope file_browser<CR>"),
    -- button( "LDR /", "   Ripgrep" , ":Telescope live_grep<CR>"),
    button( "f", "    Find file", ":cd $HOME/ | Telescope find_files<CR>"),
    button( "r", "    Recent"   , ":Telescope oldfiles<CR>"),
    button( "w", "    Find Word"   , ":Telescope live_grep<CR>"),
    -- button( "b", "    Buffers" , ":Telescope buffers<CR>"),
    -- button( "MRK V", "   Options" , ":execute 'normal! `V'<CR>"),
    -- button( "MRK P", "   Plugins" , ":execute 'normal! `P'<CR>"),
    },
    opts = {
      spacing = 1,
    }
}

local section = {
  header = header,
  buttons = buttons,
  plugin_count = plugin_count,
  heading = heading,
  footer = footer
}

local opts = {
  layout = {
    {type = "padding", val = 1},
    section.header,
    {type = "padding", val = 1},
    section.heading,
    section.plugin_count,
    {type = "padding", val = 1},
    -- section.top_bar,
    section.buttons,
    -- section.bot_bar,
    {type = "padding", val = 1},
    section.footer,
  },
  opts = {
    margin = 5
  },
}

--   local total_plugins = #vim.tbl_keys(packer_plugins)
--   local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
--   local version = vim.version()
--   local nvim_version_info =
--         "   v" .. version.major .. "." .. version.minor .. "." ..
--             version.patch
--     return datetime .. "   " .. total_plugins .. " plugins" ..
--                nvim_version_info
-- end

-- local function footer()
-- 	if version_ok and datetime_ok then
-- 		return nvim_version .. ' | ' .. datetime
-- 	elseif datetime_ok then
-- 		return datetime
-- 	else return ""
-- 	end
-- end



local logo = {
    "                                      ",
    "                                      ",
    "                                      ",
    "                                      ",
    "                                      ",
    "                                      ",
    "              ███████████             ",
    "            ████▒▒▒▒▒▒▒████          ",
    "          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██          ",
    "        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██      ",
    "      ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██     ",
    "      ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓▒▒██    ",
    "      ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓▒▒██    ",
    "    ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ▒▒██    ",
    "    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██    ",
    "    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██    ",
    "    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██    ",
    "    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██    ",
    "    ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒▒▒██    ",
    "    ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██    ",
    "    ██      ██      ████      ████    ",
    "                                      ",
    "                                      ",
    "                                      ",
    "                                      ",
    "                                      ",
    "                                      ",
    "                                      "
}

local header = {
  type = "text",
  val = {
	  '',
	  ' █████   █████ ██████████ ██████   █████    ███████    ██████   ██████',
	  '░░███   ░░███ ░░███░░░░░█░░██████ ░░███   ███░░░░░███ ░░██████ ██████ ',
	  ' ░███    ░███  ░███  █ ░  ░███░███ ░███  ███     ░░███ ░███░█████░███ ',
	  ' ░███    ░███  ░██████    ░███░░███░███ ░███      ░███ ░███░░███ ░███ ',
	  ' ░░███   ███   ░███░░█    ░███ ░░██████ ░███      ░███ ░███ ░░░  ░███ ',
	  '  ░░░█████░    ░███ ░   █ ░███  ░░█████ ░░███     ███  ░███      ░███ ',
	  '    ░░███      ██████████ █████  ░░█████ ░░░███████░   █████     █████',
	  '     ░░░      ░░░░░░░░░░ ░░░░░    ░░░░░    ░░░░░░░    ░░░░░     ░░░░░ ',
	  '',
  },
  opts = {
    position = "center",
    -- hl = "AlphaHeader"
    hl = pick_color()
  }
}

dashboard.section.header.val = header.val
dashboard.section.buttons.val = {
  dashboard.button("Ctrl+E", "  File Explorer"),
  dashboard.button("<LDR>fo", "  Find File"),
  dashboard.button("<LDR>lg", "  Git Terminal"),
  dashboard.button("<LDR>ps", "  Update plugins"),
  dashboard.button("Q", "  Quit", ":q!<CR>")
}
dashboard.section.footer.val = footer.val

alpha.setup(dashboard.opts)


-- Disable folding on alpha buffer
vim.cmd([[
  autocmd FileType alpha setlocal nofoldenable
]])

