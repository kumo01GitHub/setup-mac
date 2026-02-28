-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.automatically_reload_config = true

config.window_decorations = "RESIZE"
wezterm.on('gui-startup', function()
    wezterm.mux.spawn_window({
        position = {
            x = 400,
            y = 200,
        },
    })
end)

config.color_scheme = "catppuccin-mocha"

config.font_size = 12.0
config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })

config.use_ime = true

config.window_close_confirmation = 'NeverPrompt'

-- and finally, return the configuration to wezterm
return config
