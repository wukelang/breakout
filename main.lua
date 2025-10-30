local world = require('world')
local triangle = require('entities/triangle')
local bar = require('entities/bar')

local a = require("aa")


local frame = 0
local time = 0
local paused = false

love.draw = function()
    love.graphics.print("fps: " .. math.floor(frame / time), 0, 0)
    if paused then
        love.graphics.print("paused", 0, 10)
    end
    love.graphics.polygon('line', triangle.body:getWorldPoints(triangle.shape:getPoints()))
    love.graphics.polygon('line', bar.body:getWorldPoints(bar.shape:getPoints()))
end

love.update = function(dt)
    frame = frame + 1
    time = time + dt

    if not paused then
        world:update(dt)
    end
    -- print(triangle.body:getWorldPoints(triangle.shape:getPoints()))
    -- print(triangle.shape:getPoints())
end

local keymap = {
    escape = function()
        love.event.quit()
    end,

    space = function()
        paused = not paused
    end

}

love.focus = function(f)
    if not f then
        paused = false
    end
end

love.keypressed = function(key)
    if keymap[key] then
        keymap[key]()
    end
end
