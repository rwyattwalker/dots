local wibox = require('wibox')
local beautiful = require('beautiful')

local clock = wibox.widget.textclock('<span font="SF Pro Text 9">%d/%m %a %H:%M</span>')
return clock
