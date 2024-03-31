print("event.lua")


local event = {
    -- callbacks[i].callable
    -- callbacks[i].enabled
    callbacks = {},

}
event.__index = event;

function event:on(eName, func)
    local item = {
        callable = func,
        enabled = true
    };
    table.insert(self.callbacks[eName], item);
end
function event:trigger(eName)

end



return setmetatable({}, event);
-- Goal:
-- event = require('event.lua') 
-- event.on("timer", function()
-- -- Do stuff
-- end)
-- 
-- event.trigger("eventName")