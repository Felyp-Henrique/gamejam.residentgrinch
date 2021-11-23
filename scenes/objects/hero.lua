local Object = require('core.physics.object')
local Area = require('core.physics.area')

--- Objeto de heroi em jogo
---
--- @class HeroObject
local HeroObject = Object:new {
    type = '',
    area = nil,
}

--- Instancia um novo heroi
---
---@param obj table
---@return HeroObject
function HeroObject:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

return HeroObject