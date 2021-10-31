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
    self.tiles.water = Image:new()
    self.tiles.water.path = 'assets/tiles/caves/water.png'
    self.tiles.rockBig = Image:new()
    self.tiles.rockBig.path = 'assets/tiles/caves/rock_big.png'
    self.tiles.rockLittle = Image:new()
    self.tiles.rockLittle.path = 'assets/tiles/caves/rock_little.png'
    -- load geral
    self.effects.fog:load()
    self.tiles.floor.x = (love.graphics.getWidth() / 2)
    self.tiles.floor.y = (love.graphics.getHeight() / 2)
    self.tiles.floor.sx = 1
    self.tiles.floor.sy = 1
    self.tiles.floor:load()
    self.tiles.floor.ox = self.tiles.floor.width / 2
    self.tiles.floor.oy = self.tiles.floor.height / 2
    self.tiles.water:load()
    self.tiles.rockBig:load()
    self.tiles.rockLittle:load()
    self.match:load()
end

function CavesScene:draw()
    -- chao
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
    -- agua
    love.graphics.draw(
        self.tiles.water.image,
        love.graphics.getWidth() * 0.4,
        love.graphics.getHeight() * 0.3,
        0
    )
    love.graphics.draw(
        self.tiles.water.image,
        love.graphics.getWidth() * 0.8,
        love.graphics.getHeight() * 0.4,
        0
    )
    love.graphics.draw(
        self.tiles.water.image,
        love.graphics.getWidth() * 0.6,
        love.graphics.getHeight() * 0.8,
        0
    )
    love.graphics.draw(
        self.tiles.water.image,
        love.graphics.getWidth() * 0.2,
        love.graphics.getHeight() * 0.7,
        0
    )
    love.graphics.draw(
        self.tiles.water.image,
        love.graphics.getWidth() * 0.9,
        love.graphics.getHeight() * 0.1,
        0
    )
    -- rocks
    love.graphics.draw(
        self.tiles.rockBig.image,
        love.graphics.getWidth() * 0.5,
        love.graphics.getHeight() * 0.8,
        0
    )
    love.graphics.draw(
        self.tiles.rockBig.image,
        love.graphics.getWidth() * 0.2,
        love.graphics.getHeight() * 0.2,
        0
    )
    love.graphics.draw(
        self.tiles.rockBig.image,
        love.graphics.getWidth() * 0.8,
        love.graphics.getHeight() * 0.3,
        0
    )
    -- little rocks
    love.graphics.draw(
        self.tiles.rockLittle.image,
        love.graphics.getWidth() * 0.4,
        love.graphics.getHeight() * 0.7,
        0
    )
    love.graphics.draw(
        self.tiles.rockLittle.image,
        love.graphics.getWidth() * 0.6,
        love.graphics.getHeight() * 0.3,
        0
    )
    -- outros
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
