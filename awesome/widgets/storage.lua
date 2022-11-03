local wibox = require('wibox')
local watch = require('awful.widget.watch')
local beautiful = require('beautiful')

local storage = wibox.widget.textbox()
storage.font = beautiful.font

watch('bash -c "df -h $HOME | awk \'/[0-9]/ {print $2-$3}\'"', 30, function(_, stdout)
    local number = stdout
    storage.text = number .. "GB"
end)

return storage
