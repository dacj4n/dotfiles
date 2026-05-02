local wezterm = require("wezterm")
local act = wezterm.action

-- ============================================================
-- 启动事件
-- ============================================================

wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  -- 左上角坐标（macOS 有效）
  window:gui_window():set_position(400, 200)
end)

-- ============================================================
-- Leader 键（Cmd+B，macOS 风格）
-- ============================================================

local leader = { key = "b", mods = "SUPER", timeout_milliseconds = 1500 }

-- ============================================================
-- 按键表：调整 Pane 大小（进入后可连续按 h/j/k/l，Esc 退出）
-- ============================================================

local key_tables = {
  resize_pane = {
    { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
    { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
    { key = "Escape", action = "PopKeyTable" },
  },
}

-- ============================================================
-- 快捷键
-- ============================================================

local keys = {
  -- ----------------------------------------------------------
  -- Option + 左右箭头：按单词移动光标
  -- ----------------------------------------------------------
  { key = "LeftArrow",  mods = "ALT", action = act.SendKey({ key = "b", mods = "ALT" }) },
  { key = "RightArrow", mods = "ALT", action = act.SendKey({ key = "f", mods = "ALT" }) },

  -- ----------------------------------------------------------
  -- Cmd+R ：水平分割 Pane（左右分屏）
  -- Cmd+D ：垂直分割 Pane（上下分屏）
  -- ----------------------------------------------------------
  { key = "r", mods = "SUPER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "d", mods = "SUPER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

  -- ----------------------------------------------------------
  -- Leader(Cmd+B) + h/j/k/l ：进入调整大小模式（连续按，Esc 退出）
  -- ----------------------------------------------------------
  { key = "h", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
  { key = "j", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
  { key = "k", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
  { key = "l", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },

  -- ----------------------------------------------------------
  -- Leader(Cmd+B) + 方向键 ：在 Pane 之间切换
  -- ----------------------------------------------------------
  { key = "LeftArrow",  mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
  { key = "UpArrow",    mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "DownArrow",  mods = "LEADER", action = act.ActivatePaneDirection("Down") },

  -- ----------------------------------------------------------
  -- Leader(Cmd+B) + Space ：切换当前 Pane 的全屏/还原
  -- ----------------------------------------------------------
  { key = " ", mods = "LEADER", action = act.TogglePaneZoomState },
}

-- ============================================================
-- 主配置
-- ============================================================

local config = {
  -- ----------------------------------------------------------
  -- 字体
  -- ----------------------------------------------------------
  font_size = 14,
  font = wezterm.font_with_fallback({
    { family = "JetBrains Mono", weight = "Bold" },
    { family = "Heiti SC", weight = "Medium" },
    "Songti SC",
    "GB18030 Bitmap",
  }),

  -- ----------------------------------------------------------
  -- 配色方案
  -- ----------------------------------------------------------
  color_scheme = "Catppuccin Mocha",
  -- color_scheme = "Ayu Mirage",

  -- ----------------------------------------------------------
  -- 窗口外观
  -- ----------------------------------------------------------
  initial_cols = 160,
  initial_rows = 45,
  window_decorations = "RESIZE",
  adjust_window_size_when_changing_font_size = false,
  window_padding = {
    left = 10,
    right = 10,
    top = 20,
    bottom = 5,
  },

  -- ----------------------------------------------------------
  -- Tab 栏
  -- ----------------------------------------------------------
  use_fancy_tab_bar = false,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,
  show_new_tab_button_in_tab_bar = true,

  -- ----------------------------------------------------------
  -- 背景与透明
  -- ----------------------------------------------------------
  macos_window_background_blur = 70,
  text_background_opacity = 0.7,
  background = {
    {
      source = {
        File = "/Volumes/文档/视图/壁纸/电脑壁纸/wallhaven-ogd6xm_3840x2160.png",
      },
      hsb = {
        hue = 1.0,
        saturation = 1.02,
        brightness = 0.25,
      },
    },
    {
      source = {
        Color = "#282c35",
      },
      width = "100%",
      height = "100%",
      opacity = 0.4,
    },
  },

  -- ----------------------------------------------------------
  -- 滚动
  -- ----------------------------------------------------------
  enable_scroll_bar = true,
  scrollback_lines = 30000,

  -- ----------------------------------------------------------
  -- 快捷键与 Leader
  -- ----------------------------------------------------------
  leader = leader,
  key_tables = key_tables,
  keys = keys,
}

return config
