local world = require('world')
local entities = require('entities')

local frame = 0
local time = 0
local paused = false


love.draw = function()
    love.graphics.print("fps: " .. math.floor(frame / time), 0, 0)
    if paused then
        love.graphics.print("paused", 0, 10)
    end

    for _, entity in ipairs(entities) do
        if entity.draw then entity:draw() end
    end
end

love.update = function(dt)
    frame = frame + 1
    time = time + dt

    if not paused then
        world:update(dt)
    end
end

love.focus = function(f)
    if not f then
        paused = false
    end
end

local keymap = {
    escape = function()
        love.event.quit()
    end,

    space = function()
        paused = not paused
    end
}

love.keypressed = function(key)
    if keymap[key] then
        keymap[key]()
    end
end
