-- ===================================================================
-- Initialization
-- ===================================================================

local awful = require("awful")
local gears = require("gears")
local mirage = {}

mirage.initialize = function()
   require("components.titlebar")
   -- Import panels
--      local icon_dir = gears.filesystem.get_configuration_dir() .. "/icons/tags/mirage/"
   --   local tags = { 'web', 'dev', 'hentai'}
screen.connect_signal("request::desktop_decoration", function(s)
   awful.tag({ "", "", "", "", "", "", "", "" }, s, awful.layout.suit.tile)
   end)
     -- set initally selected tag to be active
   local initial_tag = awful.screen.focused().selected_tag
 --  awful.tag.seticon(icon_dir .. initial_tag.name .. ".png", initial_tag)

   -- updates tag icons
  -- local function update_tag_icons()
      -- get a list of all tags
   --    local atags = awful.screen.focused().tags
   --
   --    -- update each tag icon
   --    for i, t in ipairs(atags) do
   --       -- don't update active tag icon
   --       if t == awful.screen.focused().selected_tag then
   --          goto continue
   --       end
   --       -- if the tag has clients use busy icon
   --       for _ in pairs(t:clients()) do
   --          awful.tag.seticon(icon_dir .. t.name .. "-busy.png", t)
   --          goto continue
   --       end
   --       -- if the tag has no clients use regular inactive icon
   --       awful.tag.seticon(icon_dir .. t.name .. "-inactive.png", t)
   --
   --       ::continue::
   --    end
   -- end

   -- Update tag icons when tag is switched
 --  tag.connect_signal("property::selected", function(t)
      -- set newly selected tag icon as active
   --   awful.tag.seticon(icon_dir .. t.name .. ".png", t)
     -- update_tag_icons()
  -- end)
   -- Update tag icons when a client is moved to a new tag
 --  tag.connect_signal("tagged", function(c)
  --    update_tag_icons()
  -- end)
end

return mirage
