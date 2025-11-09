local world = require('world')
local entities = require('entities')
local input = require('input')

local frame = 0
local time = 0
local inputDisplay = ""

love.draw = function()
    love.graphics.print("fps: " .. math.floor(frame / time), 0, 0)
    if input.paused then
        love.graphics.print("paused", 0, 10)
    end
    love.graphics.print("input: " .. inputDisplay, 0, 20)

    for _, entity in ipairs(entities) do
        if entity.draw then entity:draw() end
    end
end

love.update = function(dt)
    frame = frame + 1
    time = time + dt

    if not input.paused then
        for _, entity in ipairs(entities) do
            if entity.update then entity:update(dt) end
        end

        world:update(dt)
    end
end

love.focus = function(focused)
    input.toggle_focus(focused)
end

love.keypressed = function(key)
    inputDisplay = key
    input.press(key)
end

love.keyreleased = function(key)
    inputDisplay = ""
    input.release(key)
end