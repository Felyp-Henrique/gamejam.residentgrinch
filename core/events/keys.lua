local Event = require('core.events.event')

--- Estrutura para eventos de teclado
---
--- @class KeysEvent
--- @field pause boolean parar eventos temporariamente
--- @field events table[] lista de eventos
local KeysEvent = Event:new {
    pause = false,
}

function KeysEvent:new(obj)
    obj = obj or {
        events = {},
    }
    self.__index = self
    return setmetatable(obj, self)
end

function KeysEvent:keypressed(key, scancode, isrepeat)
    if self.events[key] then
        self.events[key](isrepeat)
    end
end

return KeysEvent