print("event.lua")


local event_t = {
    eventsList_t = {},
}

function event_t:new()
    self = setmetatable({}, {__index = event_t});
    self.eventsList_t = {};
    return self;
end
function event_t:clear()
    self.eventsList_t = {};
end


function event_t:on(name, callback)
    if not self.eventsList_t[name] then
        self.eventsList_t[name] = {};
    end
    local item_t = {
        callable = callback,
        enabled = true
    }
    table.insert(self.eventsList_t[name], item_t);

    return function()
        self.remove(name, callback);
    end
end
function event_t:remove(name, callback)
    for i, _callback in ipairs(self.eventsList_t[name] or {}) do
        if _callback == callback then
            table.remove(self.eventsList_t[name], i);
        end
    end
end

function event_t:trigger(name, ...)
    for _, item_t in ipairs(self.eventsList_t[name] or {}) do
        if item_t.enabled then
            item_t.callable(...);
        end
    end
end


return event_t:new();
-- Goal:
-- event = require('event.lua')
-- event.on("eventName", function()
-- -- Do stuff
-- end)
--
-- event.trigger("eventName")
