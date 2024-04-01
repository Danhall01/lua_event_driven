print("test.lua")

local event = require('scripts.utility.event')

event:on("foo", function ()
    print("foo, has happened!");
end);

local off = event:on("foo", function(nr)
    if nr then
        print("Event called by number: " .. nr);
    end
end)

while true do
    local arg = io.read("n");
    if arg == 1 then
        event:trigger("foo", arg);
    end
    if arg == 2 then
        off();
    end
end
