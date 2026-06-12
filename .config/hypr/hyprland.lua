------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080",
    position = "0x0",
    scale    = "1",
})

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal      = "alacritty"
local fileManager   = "nemo"
local menu          = "hyprlauncher"
local screenlock    = "hyprlock"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function () 
    hl.exec_cmd("waybar --config ~/.config/waybar/hypr-config.jsonc")

    local wobsock = os.getenv("XDG_RUNTIME_DIR") .. "/wob.sock"
    hl.exec_cmd("sh -c 'rm -f " .. wobsock .. " && mkfifo " .. wobsock .. " && tail -f " .. wobsock .. " | wob'")

    hl.exec_cmd("systemctl --user import-environment DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE SSH_AUTH_SOCK")

    hl.exec_cmd("systemctl --user start hyprpolkitagent")

    hl.exec_cmd("systemctl --user start hyprpaper.service")

    hl.exec_cmd("hyprpm reload")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "BreezeX-Dark")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

hl.config({
  ecosystem = {
    enforce_permissions = true,
  },
})

hl.permission({ binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(bin|sbin|local/bin)/hyprpm", type = "plugin", mode = "allow" })
hl.permission({ binary = "/usr/(bin|sbin|local/bin)/hyprlock", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(bin|sbin|local/bin)/grim", type = "screencopy", mode = "allow" })

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 2,
        gaps_out = 5,

        border_size = 2,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "hy3",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
        disable_splash_rendering = true,
    },

    plugin = {
        hy3 = {
            tab_first_window = false,

            autotile = {
                enable = false,
            },

            tabs = {
                colors = {
                    active        = "0x7aa2f7ff",
                    active_border = "0xff7aa2f7",
                    active_text   = "0xff000000",
                },
            }
        }
    }
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        force_split = 2,
        preserve_split = true,
        smart_resizing = false,
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "euro",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "ALT"
local SCRIPT_DIR = os.getenv("HOME") .. "/.local/bin"
local hy3 = hl.plugin.hy3

hl.bind("SUPER + l", hl.dsp.exec_cmd(screenlock))

hl.bind(mainMod .. " + w", hy3.change_group("tab"))
hl.bind(mainMod .. " + e", hy3.change_group("untab"))
hl.bind(mainMod .. " + b", hy3.make_group("h", { toggle = true }))
hl.bind(mainMod .. " + v", hy3.make_group("v", { toggle = true }))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + m", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + p", hl.dsp.window.pseudo())

hl.bind(mainMod .. " + SHIFT + q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + u", hl.dsp.exec_cmd(SCRIPT_DIR .. "/run-uxplay.sh"))
hl.bind(mainMod .. " + SHIFT + Space", function()
    local win = hl.get_active_window()
    if win then
        hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    end
end)

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + h", hy3.move_focus("left"))
hl.bind(mainMod .. " + j", hy3.move_focus("down"))
hl.bind(mainMod .. " + k", hy3.move_focus("up"))
hl.bind(mainMod .. " + l", hy3.move_focus("right"))

-- Move the focused window
hl.bind(mainMod .. " + SHIFT + h", hy3.move_window("left"))
hl.bind(mainMod .. " + SHIFT + j", hy3.move_window("down"))
hl.bind(mainMod .. " + SHIFT + k", hy3.move_window("up"))
hl.bind(mainMod .. " + SHIFT + l", hy3.move_window("right"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hy3.move_to_workspace(tostring(i)))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + s",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + s", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd(SCRIPT_DIR .. "/screen-brightness-ctl.sh increment"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd(SCRIPT_DIR .. "/screen-brightness-ctl.sh decrement"),   { locked = true, repeating = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(SCRIPT_DIR .. "/audioctl.sh @DEFAULT_SINK@ increment"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(SCRIPT_DIR .. "/audioctl.sh @DEFAULT_SINK@ decrement"), { locked = true, repeating = true })

hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(SCRIPT_DIR .. "/audioctl.sh @DEFAULT_SINK@ toggle"),    { locked = true, repeating = false })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(SCRIPT_DIR .. "/audioctl.sh @DEFAULT_SOURCE@ toggle"),  { locked = true, repeating = false })

hl.bind("XF86RotateWindows",    hl.dsp.exec_cmd(SCRIPT_DIR .. "/toggle-screen-rotation.sh"),            { locked = false, repeating = false })

hl.bind(mainMod .. " + r", hl.dsp.submap("Resize"))

hl.define_submap("Resize", function()
    hl.bind(mainMod .. " + l", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
    hl.bind(mainMod .. "+ h", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
    hl.bind(mainMod .. "+ k", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
    hl.bind(mainMod .. "+ j", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })

    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind(mainMod .. "+ r", hl.dsp.submap("reset"))
end)

hl.bind("Print", hl.dsp.exec_cmd(SCRIPT_DIR .. "/toggle-screenshot.sh save area"), { locked = false, repeating = false })
hl.bind(mainMod .. " + Print", hl.dsp.submap("Screenshot"), { locked = false, repeating = false })

hl.define_submap("Screenshot", function()
    hl.bind(mainMod .. " + s + v", hl.dsp.exec_cmd(SCRIPT_DIR .. "/toggle-screenshot.sh save active"), { locked = false, repeating = false })
    hl.bind(mainMod .. " + c + v", hl.dsp.exec_cmd(SCRIPT_DIR .. "/toggle-screenshot.sh copy active"), { locked = false, repeating = false })
    hl.bind(mainMod .. " + s + a", hl.dsp.exec_cmd(SCRIPT_DIR .. "/toggle-screenshot.sh save area"), { locked = false, repeating = false })
    hl.bind(mainMod .. " + c + a", hl.dsp.exec_cmd(SCRIPT_DIR .. "/toggle-screenshot.sh copy area"), { locked = false, repeating = false })
    hl.bind(mainMod .. " + s + o", hl.dsp.exec_cmd(SCRIPT_DIR .. "/toggle-screenshot.sh save output"), { locked = false, repeating = false })
    hl.bind(mainMod .. " + c + o", hl.dsp.exec_cmd(SCRIPT_DIR .. "/toggle-screenshot.sh copy output"), { locked = false, repeating = false })
    hl.bind(mainMod .. " + s + w", hl.dsp.exec_cmd(SCRIPT_DIR .. "/toggle-screenshot.sh save window"), { locked = false, repeating = false })
    hl.bind(mainMod .. " + c + w", hl.dsp.exec_cmd(SCRIPT_DIR .. "/toggle-screenshot.sh copy window"), { locked = false, repeating = false })

    hl.bind("escape", hl.dsp.submap("reset"))
    hl.bind("Print", hl.dsp.submap("reset"))
end)

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
