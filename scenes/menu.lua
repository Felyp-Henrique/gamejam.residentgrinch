MenuScene = {}

function MenuScene:new(manager)
    assert(manager, "scene manager nao pode ser nil")
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.scene = manager
    return obj
end

-- metodos principais

function MenuScene:load()
    self:__config_tela()
    self:__config_font()
    self:__config_menu()
    self:__config_keys()
    
    -- background
    self.bkground = Image:new('assets/pictures/menubkgroundrev01.png')
    self.bkground:load()
    self.bkground.x = (love.graphics.getWidth() / 2) - (self.bkground.width / 2)
    self.bkground.y = (love.graphics.getHeight() / 2) - (self.bkground.height / 2)
end

function MenuScene:update(dt)
    self:__config_tela()
    self:__config_menu()
end

function MenuScene:draw()
    love.graphics.clear()
    love.graphics.setBackgroundColor(255, 255, 255, 1)
    love.graphics.draw(self.bkground.image, self.bkground.x, self.bkground.y)
    love.graphics.print("Aqui deve conter o menu inicial" , 10  , 10)
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
        self.scene:change('battlefield')
    end
end

return MenuScene