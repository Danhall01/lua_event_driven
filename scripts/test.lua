print("test.lua")

local event = require('event')

event:on("foo", function ()
    print("foo, has happened!");
end);


while true do
    local arg = io.read("n");
    if arg == 1 then
        event:trigger("foo");
    end
end
