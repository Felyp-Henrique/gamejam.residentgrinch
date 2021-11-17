local MathUtil = require('core.utils.math')

--- Estrutura area oculpada do objeto em mapa
---
--- @class Area
--- @field x number
--- @field y number
--- @field width number
--- @field height number
local Area = {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
}

--- Instancia uma nova area
---
--- @return Area
function Area:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

--- Verifica se objeto colide com outro
---
---@param other Area
---@return boolean
function Area:collided(other)
    -- dividi os heights por 3 para diminuir mais as areas, deixando o inimigo
    -- mais proximo do heroi
    local distance = MathUtil.distance(
        self.x, self.y, other.x, other.y) - ((self.height/3) + (other.height/3))
    return distance <= 0
end

return Area