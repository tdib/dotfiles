local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.max_fps = 120
config.adjust_window_size_when_changing_font_size = false
config.window_background_opacity = 0.8
config.automatically_reload_config = true
config.macos_window_background_blur = 80
config.use_fancy_tab_bar = false
config.font_size = 21
config.window_decorations = "RESIZE"

-- Disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- Allow cmd+backspace to remove entire line
config.keys = {
  -- Set CMD+Backspace to clear line (using CTRL+U)
  {
    key = "Backspace",
    mods = "CMD",
    action = wezterm.action.SendKey({ key = "U", mods = "CTRL" }),
  },
  -- Map Command+/ to send Ctrl-/, used for commenting in vim
  {
    key = "/",
    mods = "CMD",
    action = wezterm.action.SendKey({ key = "/", mods = "CTRL" }),
  },
  -- Cmd+Shift+LeftArrow/RightArrow to reorder tabs
  {
    key = "LeftArrow",
    mods = "CMD|SHIFT",
    action = wezterm.action.MoveTabRelative(-1),
  },
  {
    key = "RightArrow",
    mods = "CMD|SHIFT",
    action = wezterm.action.MoveTabRelative(1),
  },
  -- Opt+Left and Opt+Right as ALT-b, ALT-f respectively to jump words
  {
    key = "LeftArrow",
    mods = "OPT",
    action = wezterm.action.SendKey({ key = "b", mods = "ALT" }),
  },
  {
    key = "RightArrow",
    mods = "OPT",
    action = wezterm.action.SendKey({ key = "f", mods = "ALT" }),
  },
  -- Map Option + Backspace to delete the previous word
  {
    key = "Backspace",
    mods = "OPT",
    action = wezterm.action.SendKey({ key = "w", mods = "CTRL" }),
  },
  -- Command + Left to move to the start of the line
  {
    key = "LeftArrow",
    mods = "CMD",
    action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
  },
  -- Command + Right to move to the end of the line
  {
    key = "RightArrow",
    mods = "CMD",
    action = wezterm.action.SendKey({ key = "e", mods = "CTRL" }),
  },
}

return config
