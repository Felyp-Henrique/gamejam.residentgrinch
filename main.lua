local SceneManager = require('core.scenes.manager')
local LoveScene = require('scenes.love')
local MenuScene = require('scenes.menu')
local CreditosScene = require('scenes.creditos')
local EquipeScene = require('scenes.equipe')

function love.load()
    -- configurar game
    love.window.setIcon(love.image.newImageData('assets/icons/logo.png'))
    love.window.setTitle('Resident Grinch 1')

    -- configurar cenas
    Game = SceneManager:new {
        showing = 'love',
    }

    Game:add('love', LoveScene:new {
        manager = Game,
    })

    Game:add('equipe', EquipeScene:new {
        manager = Game,
    })

    Game:add('menu', MenuScene:new {
        manager = Game,
    })

    Game:add('creditos', CreditosScene:new {
        manager = Game,
    })
end

function love.draw()
    if Game:get()['draw'] then
        Game:get():draw()
    end
end

function love.update(dt)
    if Game:get()['update'] then
        Game:get():update(dt)
    end
end

function love.keypressed(key, scancode, isrepeat)
    if Game:get()['keypressed'] then
        Game:get():keypressed(key, scancode, isrepeat)
    end
end

function love.mousepressed(x, y, button)
    if Game:get()['mousepressed'] then
        Game:get():mousepressed(x, y, button)
    end
end