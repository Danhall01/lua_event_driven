print("event.lua")


local event = {
    eventsList = {},
}

function event:new()
    self = setmetatable({}, {__index = event});
    self.eventsList = {};
    return self;
end
function event:clear()
    self.eventsList = {};
end


function event:on(name, callback)
    if not self.eventsList[name] then
        self.eventsList[name] = {};
    end
    local item = {
        callable = callback,
        enabled = true
    }
    table.insert(self.eventsList[name], item);

    return function()
        self.remove(name, callback);
    end
end
function event:remove(name, callback)
    for i, _callback in ipairs(self.eventsList[name] or {}) do
        if _callback == callback then
            table.remove(self.eventsList[name], i);
        end
    end
end

function event:trigger(name, ...)
    for _, item in ipairs(self.eventsList[name] or {}) do
        if item.enabled then
            item.callable(...);
        end
    end
end


return event:new();
-- Goal:
-- event = require('event.lua')
-- event.on("eventName", function()
-- -- Do stuff
-- end)
--
-- event.trigger("eventName")
