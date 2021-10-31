local Image = require('core.image')
local anim8 = require('core.anim8')
local flux = require('core.flux')
local Area = require('core.physics.area')

Enemy = {}

function Enemy:new(values)
    values = values or {}
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.nick = values.nick or ""
    self.life = values.life or 100
    self.points = values.points or 1
    self.force = values.force or 10
    self.x = values.x or 0
    self.y = values.y or 0
    self.r = values.r or 0
    self.sx = 0
    self.sy = 0
    self.sprite = values.sprite or nil
    self.spdeath = values.spdeath or nil
    self.audio_death = values.audio or nil
    self.audioplay_death = true
    self.audio_spawn = values.audio or nil
    self.audioplay_spawn = true
    self.isWalking = true
    self.state = 'walking'
    self.area = Area:new()
    self.tween = nil
    return obj
end

-- metodos principais

function Enemy:danger(force)
    self.life = self.life - force
end

function Enemy:setState(state)
    self.state = state
end

-- metodos para o love

function Enemy:load()
    self.sprite:load()
    self.spdeath:load()

    self.sx = 1
    self.sy = 1

    local x, y = self:__getCenter()
    -- math.atan2(love.mouse.getX() - x, y - love.mouse.getY())
    -- self.r = math.atan2(x - self.x, y - self.y) - 0.5

    self.area.width = self.sprite.width
    self.area.height = self.sprite.height
    self.area.x = self.x
    self.area.y = self.y

    ww = self.sprite.width
    hh = self.sprite.height
    -- ANIM8
    local g = anim8.newGrid(32, 32, self.sprite.width, self.sprite.height)
    self.animation = anim8.newAnimation(g('1-4',1), 0.5)
                    --g(gridindex 1 até 4, grid passo?), duracaoEmSecsPORFRAME)

    -- apenas para testes, deixar valores "rapidos"
    self.tween = flux.to(self, 2, { x = 400, y =  300})
    self.tween:ease("linear"):delay(0)
    -- delay: o movimento começa após n segundos
    -- ease: é o formato -> ver em: https://github.com/rxi/flux/ -> nem todas funcionam, ver code
    -- x e y é o alvo (centro da tela)
    -- numero 10 -> tempo de processamento da origem até o destino
    -- self!

    self.r = math.atan2(400 - self.x, self.y - 300)
end

function Enemy:update(dt)
    -- ANIM8
    if self.state ~= 'stoped' then
        self.animation:update(dt)
    else
        self.tween:stop()
    end
    self.area.x = self.x
    self.area.y = self.y

    self:speech()
end

function Enemy:draw()
    love.graphics.setColor(1,1,1,1)

    -- ANIM8
     self.animation:draw(self.sprite.image,self.x,self.y,self.r,self.sx,self.sy,self.sprite.ox,self.sprite.oy)
end

function Enemy:__getCenter()
    local x = (love.graphics.getWidth() / 2)
    local y = (love.graphics.getHeight() / 2)
    return x, y
end

function Enemy:speech()
    -- death    
    if (self.life >= 0) and (self.audioplay_death) then 
        self.audio_death:setVolume( 0.5 )
        self.audio_death:play()
        self.audioplay_death = false
    end

    -- spawn
    if self.audioplay_spawn then 
        self.audio_spawn:setVolume( 0.1 )
        self.audio_spawn:play()
        self.audioplay_spawn = false
    end
end

return Enemy