local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.window_close_confirmation = "NeverPrompt"
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.max_fps = 120
config.adjust_window_size_when_changing_font_size = false
config.window_background_opacity = 0.8
config.automatically_reload_config = true
config.macos_window_background_blur = 80
config.font_size = 21
config.use_fancy_tab_bar = true
config.window_frame = {
  font = wezterm.font({ family = "JetBrains Mono", weight = "Bold" }),
  font_size = 18.0,
}

-- Dynamically rename tab titles that have nvim open
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  local process = pane.foreground_process_name:match("([^/]+)$") or ""
  local cwd = pane.current_working_dir and pane.current_working_dir.file_path or ""
  local dir = cwd:match("([^/]+)$") or ""

  if process == "nvim" and dir ~= "" then
    return "nvim (" .. dir .. ")"
  end
end)

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
