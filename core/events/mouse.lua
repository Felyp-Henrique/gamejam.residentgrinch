local Event = require('core.events.event')

--- Estrutura para eventos de teclado
---
--- @class MouseEvent
--- @field pause boolean parar eventos temporariamente
--- @field events table[] lista de eventos
local MouseEvent = Event:new()

MouseEvent.left = 1
MouseEvent.right = 2

function MouseEvent:new(obj)
    obj = obj or {
        events = {},
    }
    self.__index = self
    return setmetatable(obj or {}, self)
end

function MouseEvent:mousepressed(x, y, button)
    if self.events[button] then
        self.events[button]()
    end
end

return MouseEvent