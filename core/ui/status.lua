Status = {}

function Status:new(match)
    assert(match, 'match nao pode ser nil')
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.match = match
    return obj
end

function Status:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Vida: " .. tostring(self.match.hero.life), 10, 10)
    love.graphics.print("Pontos: " .. tostring(self.match.points), 10, 30)
end

return Status