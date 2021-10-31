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
    if area.x >= (self.x - 10) and
       area.x <= (self.width + 10) and
       area.y >= (self.y - 10) and
       area.y <= (self.height + 10)
    then
        return true
    end
    return false
end

return Area