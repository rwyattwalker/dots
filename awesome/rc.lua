--       █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗
--      ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝
--      ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗
--      ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝
--      ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗
--      ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝


-- Standard awesome libraries
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
-- Import theme
local beautiful = require("beautiful")
beautiful.init("~/.config/awesome/my-theme.lua")
-- define default apps (global variable so other components can access it)
apps = {
   network_manager = "", -- recommended: nm-connection-editor
   power_manager = "", -- recommended: xfce4-power-manager
   terminal = "alacritty",
   launcher = "rofi -modi drun -show drun -theme ~/.config/awesome/scripts/rofi.rasi",
   lock = "i3lock -B sigma --blur=5 --inside-color=282828ff --ring-color=3c3836ff  --keyhl-color=8ec07cff --bshl-color=fe8019ff  --insidewrong-color=282828ff --ringwrong-color=fb4934ff --ringver-color=fabd2fff --insidever-color=282828ff -f --verif-text='' --wrong-text='' ",
   screenshot = "scrot -e 'mv $f ~/Pictures/ 2>/dev/null'",
   filebrowser = "ranger"
}
-- define wireless and ethernet interface names for the network widget
-- use `ip link` command to determine these
network_interfaces = {
   wlan = 'wlp1s0',
   lan = 'enp1s0'
}
-- List of apps to run on start-up
local run_on_start_up = {
   "picom --experimental-backends --config ~/.config/awesome/configuration/picom.conf",
   "redshift",
   "unclutter"
}
--Import Exit Screen
require("components.exit-screen")
--Import Title Bar
require("components.titlebar")
-- Import notification appearance
require("components.notifications")
-- Run all the apps listed in run_on_start_up
for _, app in ipairs(run_on_start_up) do
   local findme = app
   local firstspace = app:find(" ")
   if firstspace then
      findme = app:sub(0, firstspace - 1)
   end
   -- pipe commands to bash to allow command to be shell agnostic
   awful.spawn.with_shell(string.format("echo 'pgrep -u $USER -x %s > /dev/null || (%s)' | bash -", findme, app), false)
end

-- Create Taglist
local createTags = function()
    screen.connect_signal("request::desktop_decoration", function(s)
       awful.tag({ "", "", "", "", "", "", "", "" }, s, awful.layout.suit.tile)
    end)
end
createTags()
require("components.top-bar")
-- Import Keybinds
local keys = require("keys")
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

-- Import rules
local create_rules = require("rules").create
awful.rules.rules = create_rules(keys.clientkeys, keys.clientbuttons)

-- Define layouts
awful.layout.layouts = {
   awful.layout.suit.tile,
   awful.layout.suit.floating,
   awful.layout.suit.max,
}

-- remove gaps if layout is set to max
tag.connect_signal('property::layout', function(t)
   local current_layout = awful.tag.getproperty(t, 'layout')
   if (current_layout == awful.layout.suit.max) then
      t.gap = 0
   else
      t.gap = beautiful.useless_gap
   end
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
   -- Set the window as a slave (put it at the end of others instead of setting it as master)
   if not awesome.startup then
      awful.client.setslave(c)
   end

   if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
   end
end)
-- ===================================================================
-- Client Focusing
-- ===================================================================
-- Autofocus a new client when previously focused one is closed
require("awful.autofocus")
-- Focus clients under mouse
client.connect_signal("mouse::enter", function(c)
   c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
-- Reload config when screen geometry changes
screen.connect_signal("property::geometry", awesome.restart)
-- ===================================================================
-- Garbage collection (allows for lower memory consumption)
-- ===================================================================
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
