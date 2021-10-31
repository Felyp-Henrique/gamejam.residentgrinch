local Match = require('core.match.match')
local Status = require('core.ui.status')
local FogEffect = require('core.effects.fog')
local Image = require('core.image')

CavesScene = {}

function CavesScene:new(manager)
    assert(manager, 'scene manager nao pode ser nil')
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.effects = {}
    self.status = nil
    self.tiles = {}
    self.match = nil
    self.scene = manager
    return obj
end

-- metodos love

function CavesScene:load()
    -- configurar scene
    self.match = Match:new { manager = self.scene }
    self.status = Status:new(self.match)
    -- configurar efeitos
    self.effects.fog = FogEffect:new()
    self.effects.fog.match = self.match
    -- configurar tiles
    self.tiles.floor = Image:new()
    self.tiles.floor.path = 'assets/tiles/caves/floor.png'
    -- load geral
    self.effects.fog:load()
    self.tiles.floor.x = (love.graphics.getWidth() / 2)
    self.tiles.floor.y = (love.graphics.getHeight() / 2)
    self.tiles.floor.sx = 1
    self.tiles.floor.sy = 1
    self.tiles.floor:load()
    self.tiles.floor.ox = self.tiles.floor.width / 2
    self.tiles.floor.oy = self.tiles.floor.height / 2
    self.match:load()
end

function CavesScene:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(
        self.tiles.floor.image,
        self.tiles.floor.x,
        self.tiles.floor.y,
        0,
        self.tiles.floor.sx,
        self.tiles.floor.sy,
        self.tiles.floor.ox,
        self.tiles.floor.oy
    )
    self.match:draw()
    self.effects.fog:draw()
    self.status:draw()
end

function CavesScene:update(dt)
    self.match:update(dt)
    self.status.match = self.match
    self.effects.fog.match = self.match
    self.effects.fog:update(dt)
end

function CavesScene:mousepressed(x, y, button)
    self.match:mousepressed(x, y, button)
end

return CavesScene
