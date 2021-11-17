--- Estrutura para eventos do jogo
---
--- @class Event
--- @field pause boolean parar eventos temporariamente
--- @field events table[] lista de eventos
local Event = {
    pause = false,
    events = {},
}

function Event:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

function Event:add(name, handler)
    self.events[name] = handler
end

return Event