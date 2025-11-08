local world = require('world')
local paddle = require('entities/paddle')
local ball = require('entities/ball')
local boundary_bottom = require('entities/boundary-bottom')
local boundary_top = require('entities/boundary-top')
local boundary_left = require('entities/boundary-left')
local boundary_right = require('entities/boundary-right')
local brick = require('entities/brick')

local frame = 0
local time = 0
local paused = false

local entities = {
    boundary_bottom(400, 606),
    boundary_top(400, -6),
    boundary_left(-6, 300),
    boundary_right(805, 300),
    paddle(300, 400),
    ball(300, 300),
    brick(100, 100),
    brick(200, 100),
    brick(300, 100)
}

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
