local Image = require('core.image')

splashLove2d = {}

local function pickOneAudioIntro()
    math.randomseed(os.time())
    return "madewithlove_R_Rev0" .. tostring(math.floor(math.random(1.5,2.5))) .. ".ogg"
end

local function fadeInOut( self)
    if self.timer < self.fadeIn then 
        self.alpha = 1 - (self.fadeIn - self.timer)
    end
    if self.timer > (self.fadeIn + self.tempoTela) then
        self.alpha = (self.fadeOut - (self.timer - (self.fadeIn + self.tempoTela)))
    end   
end

function splashLove2d:new(manager)
    assert(manager ~= nil, "scene manager nao pode ser nil")
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.scene = manager
    return obj
end

-- metodos principais
function splashLove2d:load()
    -- imagem Love2d
    self.loveLogo = Image:new('assets/pictures/love2d_logo_rev01.png')
    self.loveLogo:load()
    self.loveLogo.x = (love.graphics.getWidth() / 2) - (self.loveLogo.width / 2)
    self.loveLogo.y = (love.graphics.getHeight() / 2) - (self.loveLogo.height / 2)
    self.audio = love.audio.newSource("assets/audios/" .. pickOneAudioIntro(), "static")
    self.playSound = true
    self.timer = 0
    self.fadeIn = 2 -- segundos
    self.fadeOut = 2
    self.tempoTela = 0
    self.alpha = 0 -- Se existir fadeIn
end

function splashLove2d:__config_tela()
    self.tela = self.tela or {}
    self.tela.fullscreen = self.tela.fullscreen or false
    self.tela.largura = love.graphics.getWidth()
    self.tela.altura = love.graphics.getHeight()
end

function splashLove2d:update(dt)
    if self.playSound then
        love.audio.play(self.audio)
        self.playSound = false
     end 


     fadeInOut( self )
     
     self.timer = self.timer + dt

     -- alterar cena  
     if self.timer >= (self.fadeIn + self.tempoTela + self.fadeOut) then
        -- feio, eu sei, mas funcional!!!
        love.graphics.setColor(1, 1, 1, 1)
        self.scene:change("secondsplash")
     end
     
end

function splashLove2d:draw( dt )
    love.graphics.setColor(1, 1, 1, self.alpha)
    love.graphics.draw(self.loveLogo.image, self.loveLogo.x, self.loveLogo.y)  
end

return splashLove2d