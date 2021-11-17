--- Estrutura de componente de ui
---
--- @class Component
local Component = {}

--- Instancia um novo componente
---
--- @param obj table
--- @return Component
function Component:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

return Component