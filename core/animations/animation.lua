--- Estrutura para animacoes do jogo
---
--- @class Animation
--- @field alias string
--- @field alpha number
--- @field interval number intervalo de tempo para update da animacao
--- @field duration number duracao em segundos
--- @field loaded boolean
--- @field on_start function executado ao iniciar animacao
--- @field on_finish function executado ao finalizar animacao
local Animation = {
    alias = '',
    alpha = 1,
    interval = 1,
    duration = 5,
    loaded = false,
    on_start = function (timer, dt) end,
    on_finish = function (timer, dt) end,
}

function Animation:new(obj)
    self.__index = self
    return setmetatable(obj or {}, self)
end

-- metodos que devem ser sobrescritos

function Animation:on_load()
    error('Animation:on_load não foi sobrescrito')
end

function Animation:on_draw()
    error('Animation:on_draw não foi sobrescrito')
end

--- Executado a cada intervalo
---
--- @param timer number tempo em segundos
--- @param dt number delta time
function Animation:on_interval(timer, dt)
    error('Animation:on_interval não foi sobrescrito')
end

--- Retorna se a animacao esta em execucao
---
--- @return boolean
function Animation:is_running()
    return self.__is_running
end

--- Iniciar a execucao da animacao
function Animation:start()
    self.__is_running = true
end

--- Interromper a execucao da animacao
function Animation:stop()
    self:load()
end

-- estes metodos nunca devem ser sobrescritos

function Animation:load()
    self.__is_running = false
    self.__started = false
    self.__finished = false
    self.__timerInterval = 0
    self.__timerDuration = 0
    self:on_load()
end

function Animation:draw()
    self:on_draw()
end

function Animation:update(dt)
    if not self.__is_running then
        return
    end
    self.__timerInterval = self.__timerInterval + dt
    self.__timerDuration = self.__timerDuration + dt
    if not self.__started then
        self.on_start(0, dt)
        self.__started = true
    end
    if self.__timerDuration >= self.duration then
        if not self.__finished then
            self.on_finish(self.__timerInterval, dt)
            self.__finished = true
            self:stop()
        end
        return
    end
    if self.__timerInterval >= self.interval then
        self:on_interval(self.__timerInterval, dt)
        self.__timerInterval = 0
    end
end

return Animation