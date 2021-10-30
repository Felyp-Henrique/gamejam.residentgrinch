local Image = require('core.image')

splashEquipe = {}

local function fadeInOut( self)
    if self.timer < self.fadeIn then 
        self.alpha = 1 - (self.fadeIn - self.timer)
    end
    if self.timer > (self.fadeIn + self.tempoTela) then
        self.alpha = (self.fadeOut - (self.timer - (self.fadeIn + self.tempoTela)))
    end   
end

function splashEquipe:new(manager)
    assert(manager ~= nil, "scene manager nao pode ser nil")
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.scene = manager
    return obj
end

-- metodos principais
function splashEquipe:load()
    -- imagem Love2d
    videoIntro = love.graphics.newVideo("/assets/movies/introDrafts04nonPixel.ogv") 

    self.timer = 0

    self.fadeIn = 1 -- segundos
    self.fadeOut = 2
    self.tempoTela = 3
    self.alpha = 0 
    
    self.playVideo = true
end

function splashEquipe:__config_tela()
    self.tela = self.tela or {}
    self.tela.fullscreen = self.tela.fullscreen or false
    self.tela.largura = love.graphics.getWidth()
    self.tela.altura = love.graphics.getHeight()
end

function splashEquipe:update(dt)
    if self.playVideo then 
        videoIntro:play()
        self.playVideo = false
    end
    
     fadeInOut( self )
     
     self.timer = self.timer + dt

     -- alterar cena  
     if self.timer >= (self.fadeIn + self.tempoTela + self.fadeOut) then
        love.graphics.setColor(1, 1, 1, 1)
        self.scene:change("menu")
     end
     
end

function splashEquipe:draw( dt )
    love.graphics.setColor(1, 1, 1, self.alpha)
    -- video
    love.graphics.draw(videoIntro, 0, 0)
end

function splashEquipe:keypressed(key, scancode, isrepeat)
    if key == "escape" then
        videoIntro:pause();
        self.scene:change("menu")
    end    
end

return splashEquipe