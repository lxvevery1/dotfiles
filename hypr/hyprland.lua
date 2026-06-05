-- Hyprland Lua config
-- Adapted from hyprland.conf (0.55+ Lua format)
-- https://wiki.hypr.land/Configuring/Start/

-------------------
---- COLORS -------
-------------------
-- From colors.conf (Catppuccin Mocha)
-- Available as Lua variables for use in rules, scripts, or keybinds

local colors = {
    base     = 0x1E1E2E,
    text     = 0xCDD6F4,
    subtext0 = 0xA6ADC8,
    subtext1 = 0xBAC2DE,
    surface0 = 0x313244,
    surface1 = 0x45475A,
    surface2 = 0x585B70,
    blue     = 0x89B4FA,
    lavender = 0xB4BEFE,
    yellow   = 0xF9E2AF,
    green    = 0xA6E3A1,
    red      = 0xF38BA8,
}

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@144",
    position = "0x0",
    scale    = 1,
})

-- HDMI mirror
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty --single-instance"
local fileManager = "thunar"

local bemenu_path = "/scripts/bemenu/bemenu_gruvbox.sh"
local caelestia = "caelestia shell drawers toggle launcher"
-- bemenu config is too long, so i made a script
local menu = caelestia


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("xrdb -merge ~/.Xresources")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("keyd-application-mapper -d")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")


----------------------
---- LOOK AND FEEL ---
----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 0,
        gaps_out = 0,

        border_size = 1,

        -- https://wiki.hypr.land/Configuring/Basics/Variables/#variable-types for info about colors
        col = {
            active_border   = "rgba(dfdfaf99)",
            inactive_border = "rgba(59595900)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 0,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 0.9,

        blur = {
            enabled   = false,
            size      = 5,
            passes    = 2,
            vibrancy  = 0.1696,
        },

        shadow = {
            enabled      = false,
            range        = 20,
            render_power = 2,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Animation curves and leaf animations
-- (defined even with animations disabled, for easy re-enabling later)

hl.curve("fluent_decel",    { type = "bezier", points = { {0, 0.2},  {0.4, 1}    } })
hl.curve("easeOutCirc",     { type = "bezier", points = { {0, 0.55}, {0.45, 1}   } })
hl.curve("easeOutCubic",    { type = "bezier", points = { {0.33, 1}, {0.68, 1}   } })
hl.curve("easeinoutsine",   { type = "bezier", points = { {0.37, 0}, {0.63, 1}   } })

-- Windows
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 1.5,  bezier = "easeinoutsine", style = "popin 60%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.5,  bezier = "easeOutCubic",  style = "popin 60%" })
hl.animation({ leaf = "windows",       enabled = true, speed = 1.5,  bezier = "easeinoutsine", style = "slide" })

-- Fading
hl.animation({ leaf = "fade",          enabled = true, speed = 2.5,  bezier = "fluent_decel" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1,    bezier = "fluent_decel" })
hl.animation({ leaf = "border",        enabled = true, speed = 1,    bezier = "fluent_decel" })

-- Layers
hl.animation({ leaf = "layers",        enabled = true, speed = 1.5,  bezier = "easeinoutsine", style = "popin" })

-- Workspaces
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1,    bezier = "easeOutCubic",  style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2, bezier = "fluent_decel",  style = "slidefade 10%" })


-------------------
---- LAYOUTS ------
-------------------

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})


---------------
---- MISC -----
---------------

-- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
hl.config({
    misc = {
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },

    cursor = {
        use_cpu_buffer = 1,   -- no_hardware_cursors = true (blender invisible cursor fix)
        no_warps       = false,
    },
})


---------------
---- INPUT ----
---------------

-- https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
    input = {
        kb_layout  = "us,ru",
        kb_variant = "",
        kb_model   = "",
        kb_options = "grp:alt_shift_toggle,caps:escape",

        follow_mouse = 0,
        float_switch_override_focus = 0,
        sensitivity = 0.0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
            disable_while_typing = true,
        },

        repeat_delay = 250,
        repeat_rate  = 60,
    },
})


------------------
---- GESTURES ----
------------------

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace"
})


-----------------------
---- DEVICE CONFIG ----
-----------------------

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name = "logitech-g102-lightsync-gaming-mouse",
    sensitivity = -0.7,
})


---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Launch terminal
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))

-- Close window
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- Exit Hyprland
hl.bind("SUPER + SHIFT + escape", hl.dsp.exit())

-- Toggle floating
hl.bind("SUPER + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))

-- App launcher
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))

-- Dwindle pseudo
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Dwindle togglesplit
hl.bind(mainMod .. " + V", hl.dsp.layout("togglesplit"))

-- Fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen("maximized", "toggle"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move focus with mainMod + vim keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Move windows with mainMod + SHIFT + vim keys
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Window resizing with mainMod + CTRL + vim keys
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = -60, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ x = 60, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = -60, relative = true }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = 60, relative = true }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Cycle through windows
hl.bind("ALT + TAB", hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.bring_to_top())


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Suppress maximize events from all apps (you'll probably like this)
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Assign apps to specific workspaces
hl.window_rule({
    name  = "firefox-to-ws2",
    match = { class = "^(firefox|Firefox)$" },
    workspace = 2,
})

hl.window_rule({
    name  = "spotify-to-ws8",
    match = { class = "^(spotify|Spotify)$" },
    workspace = 8,
})

hl.window_rule({
    name  = "telegram-to-ws9",
    match = { class = "^(org.telegram.desktop)$" },
    workspace = 9,
})

hl.window_rule({
    name  = "unityhub-to-ws4",
    match = { class = "^(unityhub|UnityHub)$" },
    workspace = 4,
})

-- Custom floating terminal rules
hl.window_rule({
    match = { title = "^(basilkTerm)$" },
    float = true,
    size  = "1000 600",
})

hl.window_rule({
    match = { title = "^(basilkPETerm)$" },
    float = true,
    size  = "800 700",
})

hl.window_rule({
    match = { title = "^(pythonCalcTerm)$" },
    float = true,
    size  = "400 200",
})

hl.window_rule({
    match = { title = "^(vimNotes)$" },
    float = true,
    size  = "800 700",
})

hl.window_rule({
    match = { title = "^(screenshots)$" },
    float = true,
    size  = "400 400",
})

hl.window_rule({
    match = { class = "^(unityhub)$" },
    float = true,
    size  = "1000 600",
})

-- Smart gaps / No gaps when only
-- To replicate "smart gaps" / "no gaps when only" from other WMs/Compositors, use this bad boy:
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
hl.window_rule({
    name  = "no-gaps-wtv1",
    match = { float = false, workspace = "w[tv1]" },
    border_size = 0,
    rounding    = 0,
})
hl.window_rule({
    name  = "no-gaps-f1",
    match = { float = false, workspace = "f[1]" },
    border_size = 0,
    rounding    = 0,
})

-- Workspace to monitor assignments
hl.workspace_rule({ workspace = 1,  monitor = "eDP-1" })
hl.workspace_rule({ workspace = 2,  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 3,  monitor = "eDP-1" })
hl.workspace_rule({ workspace = 4,  monitor = "eDP-1" })
hl.workspace_rule({ workspace = 5,  monitor = "eDP-1" })
hl.workspace_rule({ workspace = 6,  monitor = "eDP-1" })
hl.workspace_rule({ workspace = 7,  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 8,  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 9,  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 10, monitor = "HDMI-A-1" })

-- Source custom binds (require loads the Lua module)
require("custom_binds")
