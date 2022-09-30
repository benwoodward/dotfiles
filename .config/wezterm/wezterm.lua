local wezterm = require 'wezterm';
return {
  keys = {
    {key='UpArrow', mods='CTRL|SHIFT', action="DisableDefaultAssignment"},
    {key='DownArrow', mods='CTRL|SHIFT', action="DisableDefaultAssignment"},
    {key='PageUp', mods='SHIFT', action="DisableDefaultAssignment"},
    {key='PageDown', mods='SHIFT', action="DisableDefaultAssignment"},
    {key='PageUp', mods='CTRL|SHIFT', action="DisableDefaultAssignment"},
    {key='PageDown', mods='CTRL|SHIFT', action="DisableDefaultAssignment"},
  },
  font = wezterm.font_with_fallback({
    "Hack Nerd Font Mono",
  }),
  font_rules = {
    {
      italic = true,
      intensity = "Bold",
      font = wezterm.font("Hack Nerd Font Mono", {italic=true, weight="Bold"}),
    },
    {
      intensity = "Bold",
      font = wezterm.font("Hack Nerd Font Mono", {weight="Bold"}),
    },
  },
  font_antialias = "Subpixel",
  font_size = 17.0,
  window_padding = {
    left = 10,
    right = 10,
    top = 0,
    bottom = 0,
  },
  window_decorations = 'RESIZE',
  window_close_confirmation = 'AlwaysPrompt',
  hide_tab_bar_if_only_one_tab = true,
  enable_tab_bar = false,
  tab_close_confirmation = 'AlwaysPrompt',
  color_scheme = 'tokyo-night-storm',
  color_schemes = {
    ['tokyo-night-storm'] = {
      foreground = '#c9d3ff',
      background = '#24283b',
      cursor_fg = '#24283b',
      cursor_bg = '#c9d3ff',
      cursor_border = '#c9d3ff',
      selection_bg = '#2d4370',
      ansi = {
        '#32344a',
        '#ea4e6b',
        '#9ece6a',
        '#ff9e64',
        '#7aa2f7',
        '#ad8ee6',
        '#75c1ee',
        '#b6b9cc',
      },
      brights = {
        '#444b6a',
        '#ff4266',
        '#ace173',
        '#e0af68',
        '#9abaff',
        '#bb9af7',
        '#7dcfff',
        '#cbcff5',
      },
    },
  },
    keys = {
    {
      key = 'w',
      mods = 'CMD|CTRL',
      action = wezterm.action.CloseCurrentTab { confirm = true },
    },
  },
}
