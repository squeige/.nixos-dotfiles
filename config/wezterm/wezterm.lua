-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration table
local config = {}

-- In newer versions of wezterm, use the config builder which is more robust:
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- ================================================= --
-- YOUR CUSTOM SETTINGS GO HERE                      --
-- ================================================= --

-- Example:
   config.color_scheme = 'zenburn (terminal.sexy)'
   config.font_size = 12
   config.font = wezterm.font('FiraCode Nerd Font')
   config.enable_tab_bar = false

-- Run herdr once when the GUI starts up.
-- (When a gui-startup handler is set, wezterm does not spawn its
--  default window, so we spawn it ourselves running herdr.
--  New tabs/panes/windows opened later still get a normal shell.)
wezterm.on('gui-startup', function(cmd)
  wezterm.mux.spawn_window {
    args = { '/etc/profiles/per-user/luigi/bin/herdr' },
  }
end)

return config
