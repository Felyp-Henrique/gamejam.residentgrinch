MenuScene = {}

function MenuScene:new(manager)
    assert(manager, "scene manager nao pode ser nil")
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.scene = manager
    self.initGame = false
    return obj
end

-- metodos principais

function MenuScene:load()
    self:__config_tela()
    self:__config_font()
    self:__config_menu()
    self:__config_keys()
    
    self.globalScale = 1 -- para 800x600

    -- fade in / out
    self.alpha = 0
    self.timerFadeIn = 0
    self.timerFadeOut = 0
    self.fadeIn = 3
    self.fadeOut = 1 -- audio 5 secs

    self.initGame = false
    
    -- background
    self.bkground = Image:new()
    self.bkground.path = 'assets/pictures/menubkgroundrev01.png'
    self.bkground:load()
    self.bkground.x = (self.tela.centerx) 
    self.bkground.y = (self.tela.centery)
    -- sobrescrever ox e oy
    self.bkground.ox = self.bkground.width / 2
    self.bkground.oy = self.bkground.height / 2

    self.AudioVoice = love.audio.newSource("assets/audios/residentgrinch_Rev01.ogg", "static")
    self.playAudioVoice = false -- para sinalizar play
    self.playAudioVoiceActive = true -- tocar apenas 1 vez
    

end

function MenuScene:update(dt)
    self:__config_tela()
    self:__config_menu()

    -- calc fadeIn
    self.timerFadeIn = self.timerFadeIn + dt
    if self.timerFadeIn < self.fadeIn then 
        -- =(value-min)/(max-min)
        self.alpha = (self.timerFadeIn) / (self.fadeIn)
    end

    
    if self.initGame then 
        self.playAudioVoice = true
        self.timerFadeOut = self.timerFadeOut + dt
        -- fadeOut + audio + provavelmetne flashes:
        if self.timerFadeOut < self.fadeOut then 
            -- =(value-min)/(max-min)
            self.alpha = 1 - (self.timerFadeOut / self.fadeOut )
        end 
        
    end

    if self.playAudioVoice and self.playAudioVoiceActive then 
        love.audio.play(self.AudioVoice)
        self.playAudioVoiceActive = false
    end

    if self.timerFadeOut > self.fadeOut then 
        self.scene:change('caves')
    end
end

function MenuScene:draw()
    love.graphics.setColor(1, 1, 1, self.alpha)
     

    love.graphics.clear()
    love.graphics.setBackgroundColor(255, 255, 255, 1)
    love.graphics.draw(self.bkground.image, self.tela.centerx, self.tela.centery, 0, self.globalScale,self.globalScale, self.bkground.ox, self.bkground.oy)
    --love.graphics.print("Aqui deve conter o menu inicial" , 10  , 10)
    love.graphics.print("Pressione P para ir para prototipo fog of war" , 10  , 40)
    love.graphics.print(self.menu.text , self.menu.x  , self.menu.y)
end

function MenuScene:keypressed(key, scancode, isrepeat)
    local handler = self.keys[key]
    if handler then
        handler()
    end
end

-- helpers

function MenuScene:__config_tela()
    self.tela = self.tela or {}
    self.tela.fullscreen = self.tela.fullscreen or false
    self.tela.largura = love.graphics.getWidth()
    self.tela.altura = love.graphics.getHeight()
    self.globalScale = self.tela.altura / 600 -- 600 é a altura base
    self.tela.centerx = love.graphics.getWidth() / 2
    self.tela.centery = love.graphics.getHeight() / 2
end

function MenuScene:__config_menu()
    self.menu = self.menu or {}
    self.menu.text = "Pressione ESC para sair!"
    self.menu.x = 10
    self.menu.y = self.tela.altura - self.font:getHeight()
end

function MenuScene:__config_font()
    self.font = love.graphics.newFont(30)
end

function MenuScene:__config_keys()
    self.keys = {}
    self.keys.f11 = function ()
        self.tela.fullscreen = not self.tela.fullscreen
        love.window.setFullscreen(self.tela.fullscreen, 'desktop')
    end
    self.keys.escape = function ()
        love.event.quit(0)
    end
    self.keys.p = function()
        self.initGame = true
        -- self.scene:change('battlefield')
    end
end

return MenuScene