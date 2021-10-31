GameOverScene = {}

function GameOverScene:new(manager)
    assert(manager, "scene manager nao pode ser nil")
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.scene = manager
    return obj
end

-- metodos principais

function GameOverScene:load()
    self:__config_font()
    self:__config_keys()
end

function GameOverScene:draw()
    love.graphics.print('Game Over', 10, 300-80)
    love.graphics.print('Aperte Enter', 10, 300+80)
end

function GameOverScene:keypressed(key, scancode, isrepeat)
    local handler = self.keys[key]
    if handler then
        handler()
    end
end

-- helpers

function GameOverScene:__config_font()
    self.font = love.graphics.newFont(80)
end

function GameOverScene:__config_keys()
    self.keys = {}
    self.keys['return'] = function()
        love.event.quit('restart')
    end
end

return GameOverScene