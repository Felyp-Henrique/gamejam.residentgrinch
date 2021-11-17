local Component = require('core.ui.component')

--- Representa o placar do game
---
--- @class StatusComponent
local StatusComponent = Component:new {
    life = 100,
    points = 0,
}

--- Instancia um novo Status
---
--- @param obj table
--- @return StatusComponent
function StatusComponent:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

return StatusComponent