--
-- representa uma area de um objeto sob um plano
--

Area = {}

function Area:new()
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.x = 0
    self.y = 0
    self.width = 0
    self.height = 0
    return obj
end

function Area:collided(area)
    -- dividi os heights por 3 para diminuir mais as areas, deixando o inimigo
    -- mais proximo do heroi
    local dis = distancia(self.x, self.y, area.x, area.y) - ((self.height/3) + (area.height/3))
    return dis <= 0
end

function Area:getXs()

end

function distancia(x1, y1, x2, y2)
    return math.sqrt((x2-x1)^2 + (y2-y1)^2)
end

return Area