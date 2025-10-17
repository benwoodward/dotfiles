local wezterm = require 'wezterm'

-- ---- Palette (Tokyo Night Storm + your tab tweaks) ----
local PALETTE = {
  fg  = "#c0caf5",
  bg  = "#24283b",
  sel_bg = "#2e3c64",
  sel_fg = "#c0caf5",
  cursor_bg = "#c0caf5",
  cursor_fg = "#24283b",
  ansi = {
    "#1d202f", "#f7768e", "#9ece6a", "#e0af68",
    "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6",
  },
  brights = {
    "#414868", "#f7768e", "#9ece6a", "#e0af68",
    "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5",
  },
  idx16 = "#ff9e64",
  idx17 = "#db4b4b",

  -- Tabs
  tab_bg         = "#1A1B26", -- background for all tabs
  tab_inactive_fg= "#415C6D",
  tab_active_fg  = "#83B6AF",
}

-- ---- Helpers ----
local function abbrev_title(title)
  if #title > 25 then
    return string.sub(title, 1, 6) .. "…" .. string.sub(title, -6)
  end
  return title
end

local function pad_to(title, minw, maxw)
  local len = wezterm.column_width(title)
  local target = math.min(math.max(len, minw), maxw)
  local pad = target - len
  if pad > 0 then
    local left = math.floor(pad / 2)
    local right = pad - left
    title = string.rep(" ", left) .. title .. string.rep(" ", right)
  end
  return title
end

-- ---- Tab title formatting ----
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local index = tab.tab_index + 1
  local pane = tab.active_pane

  -- Get the process name (e.g. "nvim", "zsh", "node")
  local process = pane.foreground_process_name
  if process then
    process = string.match(process, "[^/]+$") or process -- strip path
  else
    process = ""
  end

  -- Use pane title (usually current directory or command)
  local title = pane.title or ""
  title = string.gsub(title, "^~", "") -- cleaner home path display

  -- Combine: "◉ 3:nvim — src"
  local icon = tab.is_active and "◉" or "•"
  local text = string.format(" %s %d:%s — %s ", icon, index, process, title)

  -- Limit + pad for width
  local len = wezterm.column_width(text)
  local min_width = 22
  local maxw = math.min(max_width, 80)
  if len < min_width then
    local pad = min_width - len
    text = text .. string.rep(" ", pad)
  end

  -- Colours
  local fg = tab.is_active and "#83B6AF" or "#415C6D"

  return {
    { Foreground = { Color = fg } },
    { Text = text },
  }
end)

-- ---- Config ----
local config = {}

-- Font (no fallbacks)
config.font = wezterm.font("Hack Nerd Font Mono", { weight = "Regular" })
config.font_size = 16.0
config.line_height = 1.10
config.underline_thickness = 1.10
-- If you want ligatures off globally: config.harfbuzz_features = {"calt=0","clig=0","liga=0"}

config.default_prog = { "/bin/zsh" }

-- Scrollback
config.scrollback_lines = 2000000

-- Bell
config.audible_bell = "Disabled"

-- Colours
config.colors = {
  foreground = PALETTE.fg,
  background = PALETTE.bg,   -- window background unchanged
  cursor_bg  = PALETTE.cursor_bg,
  cursor_fg  = PALETTE.cursor_fg,
  cursor_border = PALETTE.cursor_bg,
  selection_bg = PALETTE.sel_bg,
  selection_fg = PALETTE.sel_fg,
  ansi = PALETTE.ansi,
  brights = PALETTE.brights,
  indexed = {
    [16] = PALETTE.idx16,
    [17] = PALETTE.idx17,
  },
  tab_bar = {
    background = PALETTE.tab_bg,  -- bar area behind tabs
    active_tab = {
      bg_color = PALETTE.tab_bg,
      fg_color = PALETTE.tab_active_fg,
      intensity = "Bold",
      italic = true,
      underline = "None",
    },
    inactive_tab = {
      bg_color = PALETTE.tab_bg,
      fg_color = PALETTE.tab_inactive_fg,
      intensity = "Normal",
      italic = false,
      underline = "None",
    },
    inactive_tab_hover = {
      bg_color = PALETTE.tab_bg,
      fg_color = PALETTE.tab_active_fg,
      italic = false,
    },
    new_tab = {
      bg_color = PALETTE.tab_bg,
      fg_color = PALETTE.tab_inactive_fg,
    },
  },
}

-- Opacity
config.window_background_opacity = 1.0
config.text_background_opacity   = 1.0

-- Window / tabs
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 200
config.tab_bar_at_bottom = false

-- macOS Option as Alt
config.send_composed_key_when_left_alt_is_pressed  = true
config.send_composed_key_when_right_alt_is_pressed = true

-- Keys
config.keys = {
  { key = ';', mods = 'CTRL', action = 'DisableDefaultAssignment' },
  { key = 't', mods = 'CMD', action = wezterm.action.SpawnTab('CurrentPaneDomain') },
  { key = 'w', mods = 'CMD|CTRL', action = wezterm.action.CloseCurrentTab { confirm = false } },
  { key = 'RightArrow', mods = 'CMD|ALT', action = wezterm.action.MoveTabRelative(1) },
  { key = 'LeftArrow',  mods = 'CMD|ALT', action = wezterm.action.MoveTabRelative(-1) },
  { key = '1', mods = 'CMD', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'CMD', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'CMD', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'CMD', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'CMD', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'CMD', action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = 'CMD', action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = 'CMD', action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = 'CMD', action = wezterm.action.ActivateTab(8) },
  { key = 'Enter', mods = 'SHIFT', action = wezterm.action.SendString("\n") },
  { key = '3', mods = 'ALT', action = wezterm.action.SendString("#") },
  { key = 'v', mods = 'CTRL', action = wezterm.action.SendString("~/.local/bin/paste-image.sh\r") },
}

return config

