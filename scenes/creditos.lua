creditos = {}

function creditos:new(manager)
    assert(manager, "scene manager nao pode ser nil")
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.scene = manager
    self.initGame = false
    return obj
end

-- metodos principais

function creditos:load()
    self:__config_tela()
    self:__config_font()
    self:__config_keys()
    
    -- fade in / out
    self.alpha = 0
    self.timerFadeIn = 0
    self.timerFadeOut = 0
    self.fadeIn = 4
    self.fadeOut = 2 

    self.initGame = false
    
    -- background
    self.bkground = Image:new()
    self.bkground.path = 'assets/pictures/creditosScreen.png'
    self.bkground:load()
    self.bkground.x = (self.tela.centerx) 
    self.bkground.y = (self.tela.centery)
    -- sobrescrever ox e oy
    self.bkground.ox = self.bkground.width / 2
    self.bkground.oy = self.bkground.height / 2

end

function creditos:update(dt)
    self:__config_tela()

    -- calc fadeIn
    self.timerFadeIn = self.timerFadeIn + dt
    if self.timerFadeIn < self.fadeIn then 
        -- =(value-min)/(max-min)
        self.alpha = (self.timerFadeIn) / (self.fadeIn)
    end

    
    if self.initGame then 
        self.timerFadeOut = self.timerFadeOut + dt
        -- fadeOut + audio + provavelmetne flashes:
        if self.timerFadeOut < self.fadeOut then 
            -- =(value-min)/(max-min)
            self.alpha = 1 - (self.timerFadeOut / self.fadeOut )
        end 
        
    end

    if self.timerFadeOut > self.fadeOut then 
        self.scene:change('menu')
    end
end

function creditos:draw()
    love.graphics.setColor(1, 1, 1, self.alpha)
     

    love.graphics.clear()
    love.graphics.setBackgroundColor(255, 255, 255, 1)
    love.graphics.draw(self.bkground.image, self.tela.centerx, self.tela.centery, 0, self.globalScale,self.globalScale, self.bkground.ox, self.bkground.oy)
end

function creditos:keypressed(key, scancode, isrepeat)
    local handler = self.keys[key]
    if handler then
        handler()
    end
end

-- helpers

function creditos:__config_tela()
    self.tela = self.tela or {}
    self.tela.fullscreen = self.tela.fullscreen or false
    self.tela.largura = love.graphics.getWidth()
    self.tela.altura = love.graphics.getHeight()
    self.globalScale = self.tela.altura / 600 -- 600 é a altura base
    self.tela.centerx = love.graphics.getWidth() / 2
    self.tela.centery = love.graphics.getHeight() / 2
end

function creditos:__config_font()
    self.font = love.graphics.newFont(30)
end

function creditos:__config_keys()
    self.keys = {}
    self.keys['return'] = function()
        self.initGame = true
    end
    self.keys['space'] = function()
        self.initGame = true
    end
end

return creditos