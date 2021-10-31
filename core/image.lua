Image = {}

function Image:new(path)
    assert(path, "path nao pode ser nil")
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.image = nil
    self.width = 0
    self.height = 0
    self.x = 0
    self.y = 0
    self.sx = 0
    self.sy = 0
    self.path = path
    return obj
end

function Image:load()
    self.image = love.graphics.newImage(self.path)
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    return "load() " .. tostring(self.width) .. " "
end

return Image