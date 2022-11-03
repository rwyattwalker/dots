local awful = require('awful')
local beautiful = require('beautiful')
local clickable_container = require('widgets.material.clickable-container')
local mat_icon_button = require('widgets.material.icon-button')
local separators = require('widgets.material.separator')
local markup = require('widgets.material.markup')
local wibox = require('wibox')
local TagList = require('widgets.tag-list')
local network = require('widgets.network')
local volume = require('awesome-wm-widgets.volume-widget.volume')
local temp = require('widgets.temprature')
local layoutbox = require('widgets.layout-box')
local cpu = require('widgets.cpu')
local logout_popup = require('awesome-wm-widgets.logout-popup-widget.logout-popup')
local gears = require('gears')
local themes = require('theme.color-schemes')
local dpi = require('beautiful').xresources.apply_dpi
local table = awful.util.table or gears.table

screen.connect_signal("request::desktop_decoration", function(s)
   -- s.myexitscreen = exit_screen.createscreen(s)
     s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }
    layoutboxcontainer = wibox.container.margin (s.mylayoutbox, 8, 0, 4, 4)
    s.mywibox0 = awful.wibar {
        position = "top",
        visible = true,
        stretch  = false,
        width    = 40,
        screen = s,
        bg = beautiful.bg_normal,
        border_color = beautiful.border_normal,
        border_width = 2,
        spacing = 8,
        shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,4)
        end,
        height = 30,
        margins = {
            top = 12,
            left = 4,
        },
        align    = "left",
        widget   = layoutboxcontainer
    }

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        style    = {
            spacing = 8,
            shape        = function(cr,w,h)
                             gears.shape.rounded_rect(cr,w,h,4)
                            end,
            bg_focus = "#d3869b",
            fg_focus = "#ebdbb2",
            fg_empty = "#ebdbb2",
            fg_occupied = "#ebdbb2",
            bg_empty = beautiful.bg_normal,
            bg_occupied = beautiful.bg_normal,
            font = "SF Pro Text 30"
        },
    layout   = {
        spacing = -12,
        spacing_widget = {
            color  = "#dddddd",
            widget = wibox.widget.separator,
        },
        layout  = wibox.layout.fixed.horizontal
    },
    widget_template = {
        {
            {
                {
                   {
                    id     = "text_role",
                    widget = wibox.widget.textbox,
                   },
                   left = 12,
                   right = 14,
                   widget = wibox.container.margin,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            left  = 0,
            right = 0,
            widget = wibox.container.margin
        },
        id     = "background_role",
        widget = wibox.container.background,
        create_callback = function(self, c3, index, objects) --luacheck: no unused args
            self:get_children_by_id('text_role')[1].markup = '<b> '..index..' </b>'
            self:connect_signal('mouse::enter', function()
            end)
            self:connect_signal('mouse::leave', function()
            end)
        end,
        update_callback = function(self, c3, index, objects) --luacheck: no unused args
            self:get_children_by_id('text_role')[1].markup = '<b> '..index..' </b>'
        end,
         },
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        },
    }
    taglistcontainer = wibox.container.margin (s.mytaglist, 4, 4, 3, 3)
    s.mywibox1 = awful.wibar {
        position = "top",
        visible = true,
        stretch  = false,
        width    = 432,
        screen = s,
        bg = beautiful.bg_normal,
        border_color = beautiful.border_normal,
        shape        = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,4)
        end,
        border_width = 2,
        height = 30,
        margins = {
            top = -18,
            left = 52,
        },
        align    = "left",
        widget   ={
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.fixed.horizontal,
            },
            taglistcontainer,
            {
                layout = wibox.layout.fixed.horizontal
            },
        },
    }
s.mytasklist = awful.widget.tasklist {
    screen   = s,
    filter   = awful.widget.tasklist.filter.currenttags,
    buttons  = tasklist_buttons,
    style    = {
        spacing = 8 ,
        shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,5)
        end,
    },
    layout   = {
        spacing = 8,
        spacing_widget = {
            color = "#dddddd",
            widget = wibox.widget.separator
        },
        layout  = wibox.layout.fixed.horizontal
    },
    widget_template = {
        {
            {
                {
                   {
                    id     = "icon_role",
                    widget = wibox.widget.imagebox,
                   },
                left = 10,
                right = 10,
                widget = wibox.container.margin,
                },
            fg = beautiful.bg_normal,
            bg = beautiful.bg_normal,
            widget = wibox.container.background,
            },
        layout = wibox.layout.fixed.horizontal,
        },
        bg = beautiful.bg_normal,
        widget = wibox.container.background,
  },
}
 tasklistcontainer = wibox.container.margin (s.mytasklist, 4, 4, 4, 4)
   s.mywibox2 = awful.wibar {
        position = "top",
        visible = true,
        stretch  = false,
        bg = beautiful.bg_normal,
        screen = s,
        border_color = beautiful.border_normal,
        border_width = 2,
        width    = 200,
        height = 30,
        margins = {
            top = -48,
            left = 493,
        },
        shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,4)
        end,
        align    = "left",
        widget   = {
            align  = "center",
            widget = tasklistcontainer
        },
   }
   container4 = wibox.widget {
        logout_popup.widget{},
        widget = wibox.container.background,
        bg = beautiful.bg_normal,
        border_width = (0),
        border_color = beautiful.border_normal,
   }
   local clock = wibox.widget({
        font = "HackNerdFont Bold 11",
        format = "%H:%M",
        align = "center",
        valign = "center",
        widget = wibox.widget.textclock,
    })

   local container5 =
        wibox.widget {
        clock,
        widget = wibox.container.background,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 4)
        end,
        bg = beautiful.bg_normal,
        fg = "#ebdbb2",
        border_width = (0),
        border_color = beautiful.border_normal,
        forced_width = 60
    }
   local separator =   wibox.widget.separator{orientation = "vertical", thickness=2, span_ratio = 0.8, forced_width = 6, color="#7f7f7f",opactity = 1, bg = "#ebdbb2"}
   mylayoutcontainer2 = wibox.container.margin(container4, 1.5, 1.5, 1.5, 1.5)
   myclockcontainer = wibox.container.margin(container5, 0, 0, 1.5, 1.5)
   s.mylogoutbutton = awful.widget.button
   s.mywibox3 = awful.wibar {
        position = "top",
        visible = true,
        stretch  = false,
        width    = 102.5,
        bg = beautiful.bg_normal,
        screen = s,
        border_color = beautiful.border_normal,
        border_width = 2,
        height = 30,
        shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,4)
        end,
        margins = {
            top = -78,
            right = 5
        },
        align    = "right",
        widget   = {{
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.fixed.horizontal,
                myclockcontainer,
                wibox.widget.separator{orientation = "vertical", thickness=2, span_ratio = 0.8, forced_width = 6, color="#7f7f7f",opactity = 1, bg = "#ebdbb2"}
            },
            layout = wibox.layout.fixed.horizontal,
            mylayoutcontainer2,
        },
        top = 1.5,
        bottom =1.5,
        left = 0,
        right = 0,
        widget = wibox.container.margin
    }
    }  
     -- SYSTEM TRAY
    -- ===========
    local systray = wibox.widget.systray()
    systray:set_horizontal(true)
    local volume_widget = require('widgets.volume')
    local battery_widget = require('widgets.battery')
    local clock_widget = require('widgets.clock')
    local mem_widget = require('widgets.memory')
    local cpu_widget = require('widgets.cpu')
    local temprature_widget = require('widgets.temprature')
    local storage_widget = require('widgets.storage')
    cpucontainer = wibox.container.margin(cpu_widget, 7, 0, 0, 0)
     local system_details = wibox.widget {
         wibox.widget {
             wibox.widget{
                wibox.widget{
                    wibox.widget{
                        text = 'RAM ',
                        font = "SF Pro Text 11",
                        widget = wibox.widget.textbox
                    },
                    fg = "#b8bb25",
                    widget = wibox.container.background
                },
            top = 0,
            bottom = 0,
            left = 0,
            right = 3,
            widget = wibox.container.margin
        },
            mem_widget,
            layout = wibox.layout.fixed.vertical
        },
            separator,
            wibox.widget{
                wibox.widget{
                    wibox.widget{
                        wibox.widget{
                        text = 'CPU ﬙',
                        font = "SF Pro Text 11",
                        widget = wibox.widget.textbox
                         },
                    fg = "#fb4934",
                    widget = wibox.container.background
                    },
                top = 0,
                bottom = 0,
                left = 0,
                right = 0,
                widget = wibox.container.margin
                },
            cpucontainer,
            layout = wibox.layout.fixed.vertical
        },
         --   separator,
           -- wibox.widget{
             --   wibox.widget{
               --     text = '﨎',
                  --  font =beautiful.icon_font,
                 --   widget=wibox.widget.textbox
                --},
                --fg = "#458588",
               -- widget = wibox.container.background
           -- },
           -- temprature_widget,
            separator,
            wibox.widget{
               wibox.widget{
                wibox.widget{
                    text = 'DISK ',
                    font = "SF Pro Text 11",
                    widget = wibox.widget.textbox
                },
                fg = "#fe9019",
                widget = wibox.container.background
            },
            wibox.widget{
                wibox.container.margin(storage_widget, 1.5,0,0,0),
                wibox.widget{
                    markup = " GB",
                    halign = "left",
                    valign = "left",
                    widget = wibox.widget.textbox
                },
                layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.fixed.vertical
          },
            spacing = dpi(4),
            layout = wibox.layout.fixed.horizontal
        } 
  mylayoutcontainer3 = wibox.container.margin(system_details, 6, 1.5, 1.5, 1.5)
  s.mywibox4 = awful.wibar {
        position = "top",
        visible = true,
        stretch  = false,
        width    = 150,
        height = 30,
        bg = beautiful.bg_normal,
        screen = s,
        border_color = beautiful.border_normal,
        border_width = 2,
        shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,4)
        end,
        margins = {
            top = -108,
            right = 116
        },
        align    = "right",
        widget   = mylayoutcontainer3
    }
  local connection_details = wibox.widget {
            volume,
            separator,
          --  network,
            layout = wibox.layout.fixed.horizontal
    }
    s.mywibox5 = awful.wibar {
        position = "top",
        visible = true,
        stretch  = false,
        width    = 40,
        bg = beautiful.bg_normal,
        shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,4)
        end,
        screen =s,
        border_color = beautiful.border_normal,
        border_width = 2,
        height = 30,
        margins = {
            top = -138,
            right = 274
        },
        align    = "right",
        widget   = wibox.container.margin(volume{widget_type='arc'}, 1.5, 1.5, 3.5,3.5)
    }
end)
--screen.connect_signal("request::desktop_decoration", function(s)
  --  awful.wibar {
    --    position = "top",
      --  screen   = s,
      --  height   = 48,
      --  bg       = "#0000", -- fake transparency (uses your wallpaper as background)
      --  widget   = {
        --    layoutBox, -- Left
          --  TagList(s),-- Middle widget
            --items, -- Right widget
           -- expand = "none",
           -- layout = wibox.layout.align.horizontal,
       -- }
   -- }
--end)
-- Separators
local arrow = separators.arrow_left
local function create_arrow(mywidget, bgcolor, fgcolor)
    return (wibox.container.background(
        wibox.widget {
            arrow(fgcolor, bgcolor),
            mywidget,
            arrow(bgcolor, fgcolor),
            spacing = dpi(4),
            layout = wibox.layout.fixed.horizontal
        },
        bgcolor
    )
)
end

-- Create Icons
local function create_icon(label, icon_color)
    return (wibox.widget {
        wibox.widget{
            text = label,
            font = beautiful.icon_font,
            widget = wibox.widget.textbox
        },
        fg = icon_color,
        widget = wibox.container.background
    })
end

local TopBar = function(s, offset)

    -- LAYOUT BOX
    -- ==========
    local function update_txt_layoutbox(s)
        -- Writes a string representation of the current layout in a textbox widget
        local txt_l = beautiful["layout_txt_" .. awful.layout.getname(awful.layout.get(s))] or ""
        s.layoutbox:set_text(txt_l)
    end

    s.layoutbox = wibox.widget.textbox(beautiful["layout_txt_" .. awful.layout.getname(awful.layout.get(s))])
    s.layoutbox.font = beautiful.icon_font
    awful.tag.attached_connect_signal(s, "property::selected", function () update_txt_layoutbox(s) end)
    awful.tag.attached_connect_signal(s, "property::layout", function () update_txt_layoutbox(s) end)
    s.layoutbox:buttons(table.join(
                           awful.button({}, 1, function() awful.layout.inc(1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function() awful.layout.inc(-1) end),
                           awful.button({}, 4, function() awful.layout.inc(1) end),
                           awful.button({}, 5, function() awful.layout.inc(-1) end)))

    -- SYSTEM TRAY
    -- ===========
    local systray = wibox.widget.systray()
    systray:set_horizontal(true)

    -- SYSTEM DETAILS
    -- ==============
    local volume_widget = require('widget.volume')
    local battery_widget = require('widget.battery')
    local clock_widget = require('widget.clock')
    local mem_widget = require('widget.memory')
    local cpu_widget = require('widget.cpu')
    local temprature_widget = require('widget.temprature')
    local storage_widget = require('widget.storage')
    local net = require('widget.net')
    local net_sent = net({
        settings = function()
            widget:set_markup(markup.font(beautiful.font, net_now.sent))
        end
    })
    local net_recieved = net({
        settings = function()
            widget:set_markup(markup.font(beautiful.font, net_now.received))
        end
    })
    local system_details = wibox.widget {
            -- Systray
            systray,
            create_arrow(nil, themes.gruvbox_material.primary.hue_200, themes.gruvbox_material.primary.hue_100),
            -- Internet Speed
            wibox.widget{
                create_icon('', themes.gruvbox_material.accent.hue_200),
                net_recieved.widget,
                create_icon('', themes.gruvbox_material.accent.hue_300),
                net_sent.widget,
                spacing = dpi(4),
                layout = wibox.layout.fixed.horizontal
            },
            -- Battery
            create_arrow (battery_widget, themes.gruvbox_material.primary.hue_200, themes.gruvbox_material.primary.hue_100),
            -- Memory
            create_icon('', themes.gruvbox_material.accent.hue_500),
            mem_widget,
            -- CPU
            create_arrow(wibox.widget{
                create_icon('﬙', themes.gruvbox_material.accent.hue_600),
                cpu_widget,
                spacing = dpi(4),
                layout = wibox.layout.fixed.horizontal
            }, themes.gruvbox_material.primary.hue_200, themes.gruvbox_material.primary.hue_100),
            -- Temprature
            wibox.widget{
                create_icon('﨎', themes.gruvbox_material.accent.hue_400),
                temprature_widget,
                spacing = dpi(4),
                layout = wibox.layout.fixed.horizontal
            },
            -- Volume
            create_arrow(volume_widget, themes.gruvbox_material.primary.hue_200, themes.gruvbox_material.primary.hue_100),
            -- Storage
            wibox.widget{
                create_icon('', themes.gruvbox_material.accent.hue_200),
                storage_widget,
                spacing = dpi(4),
                layout = wibox.layout.fixed.horizontal
            },
            wibox.widget{
            -- Calendar / Clock
                create_arrow(wibox.widget{
                    create_icon('', themes.gruvbox_material.accent.hue_400),
                    clock_widget,
                    spacing = dpi(4),
                    layout = wibox.layout.fixed.horizontal
                }, themes.gruvbox_material.primary.hue_200, themes.gruvbox_material.primary.hue_100),
            -- Layout
                wibox.widget {
                    arrow(themes.gruvbox_material.primary.hue_100, themes.gruvbox_material.accent.hue_200),
                    wibox.widget{
                        wibox.container.margin(s.layoutbox, dpi(4), dpi(4), dpi(0), dpi(0)),
                        fg = themes.gruvbox_material.primary.hue_100,
                        bg = themes.gruvbox_material.accent.hue_200,
                        widget = wibox.container.background
                    },
                    layout = wibox.layout.fixed.horizontal
                },
                layout = wibox.layout.fixed.horizontal,
            },
            spacing = dpi(4),
            layout = wibox.layout.fixed.horizontal
        }

    -- TOP BAR
    -- =======
    local panel = wibox({
        position = "top",
        ontop = false,
        screen = s,
        height = dpi(40),
        width = s.geometry.width,
        x = s.geometry.x,
        y = s.geometry.y,
        stretch = false,
        bg = themes.gruvbox_material.primary.hue_100,
        fg = themes.gruvbox_material.fg_normal,
    })

    panel:struts({
        top = panel.height - panel.y
    })

    panel:setup{
        layout = wibox.layout.align.horizontal,
        TagList(s),
        nil,
        system_details,
    }

    return panel
end

return TopBar
