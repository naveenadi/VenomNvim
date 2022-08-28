--https://manytools.org/hacker-tools/ascii-banner
--https://xflea.github.io/nv-dashboard-header-maker/

TODO: Config starter

local ok, alpha = pcall(require, "alpha")
if not ok then return end

theta = require("alpha.themes.theta")

local function custom_header()
  return [[
\'',
\' █████   █████ ██████████ ██████   █████    ███████    ██████   ██████',
\'░░███   ░░███ ░░███░░░░░█░░██████ ░░███   ███░░░░░███ ░░██████ ██████ ',
\' ░███    ░███  ░███  █ ░  ░███░███ ░███  ███     ░░███ ░███░█████░███ ',
\' ░███    ░███  ░██████    ░███░░███░███ ░███      ░███ ░███░░███ ░███ ',
\' ░░███   ███   ░███░░█    ░███ ░░██████ ░███      ░███ ░███ ░░░  ░███ ',
\'  ░░░█████░    ░███ ░   █ ░███  ░░█████ ░░███     ███  ░███      ░███ ',
\'    ░░███      ██████████ █████  ░░█████ ░░░███████░   █████     █████',
\'     ░░░      ░░░░░░░░░░ ░░░░░    ░░░░░    ░░░░░░░    ░░░░░     ░░░░░ ',
\'',
\]]
end


