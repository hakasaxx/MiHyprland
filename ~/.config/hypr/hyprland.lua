----MONITORES
hl.monitor({
    output = "VGA-1",
    mode = "1366x768@60",
    scale = 1,
    position = "0x0"
})
hl.monitor({
    disabled = true,
    output = "LVDS-1",
    mode = "1366x768@60",
    scale = 1,
    position = "0x-768"
})
----APPS
local archivos = "kitty -e yazi"
local terminal = "kitty"
local menu = "fuzzel"
local web = "flatpak run app.zen_browser.zen"
local captura = "hyprshot -m region"
local wallpicker = "kitty -e /usr/bin/python /home/hakasax/GITHUB/MiHyprland/MiHyprland/wallpicker.py"
----BINDS
local mod = "SUPER"
hl.bind(mod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(archivos))
hl.bind(mod .. " + F", hl.dsp.exec_cmd(web))
hl.bind(mod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + Print", hl.dsp.exec_cmd(captura))
hl.bind(mod .. " + C", hl.dsp.window.close())
hl.bind(mod .. " + W", hl.dsp.exec_cmd(wallpicker))
hl.bind(mod .. " + M", hl.dsp.exec_cmd("loginctl terminate-user \"$USER\""))
hl.bind(mod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down",  hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
----AUTOINICIO
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar &")
    hl.exec_cmd("dunst")
    hl.exec_cmd("wal -R &")
    hl.exec_cmd("awww-daemon")
end)
----VISUALES
local function clean_wal_color(color)
    if not color then
        return "rgba(9932CCee)"
    end
    local cleaned = color:gsub("rgba%(%#", "rgba(")
    return cleaned
end
local function load_wal_colors()
    local home = os.getenv("HOME")
    local file = io.open(home .. "/.cache/wal/colors-hyprland.conf", "r")
    if not file then
        return {}
    end
    local colors = {}
    for line in file:lines() do
        local var, value = line:match("^%$(%w+)%s*=%s*(.-)%s*$")
        if var and value then
            colors[var] = clean_wal_color(value)
        end
    end
    file:close()
    return colors
end
local wal = load_wal_colors()
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 15,
        border_size = 4,
        col = {
            active_border = wal.color2 or "rgba(9932CCee)",
        },
        layout = "dwindle"    
    },
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 0.5,
        blur = {
            enabled = true,
            size = 6,
            passes = 2,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
    },
})
----TECLADO
hl.config({
    input = {
        kb_layout  = "latam",
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
        },
    },
})
----COSAS Q NOSE Q MRD SON PERO ESTAN EN EL EXAMPLE
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })
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
hl.config({
    dwindle = {
        preserve_split = true,
    },
})
hl.config({
    master = {
        new_status = "master",
    },
})
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})
----WORKSPACES
for i = 1, 10 do
    local key = i % 10
    hl.bind(mod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

local suppressMaximizeRule = hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
----CURSOR
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("HYPRCURSOR_SIZE", "24")
----TRANSPARENCIA x APP
hl.window_rule({
    name = "vscode-opacity",
    match = {
        class = "^code$",
    },
    opacity = "0.7 override 0.7 override 0.7 override",
})