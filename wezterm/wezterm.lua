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
config.font_size = 14
config.window_decorations = "RESIZE"

-- Disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- Allow cmd+backspace to remove entire line
config.keys = {
  {
    key = "Backspace",
    mods = "CMD",
    -- Set CMD+Backspace to clear line (using CTRL+U)
    action = wezterm.action.SendKey({ key = "U", mods = "CTRL" }),
  },
  -- Map Command+/ to send Ctrl-/, used for commenting in vim
  {
    key = "/",
    mods = "CMD",
    action = wezterm.action.SendKey({ key = "/", mods = "CTRL" }),
  },
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
}

return config
