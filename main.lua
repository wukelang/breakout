local world = require('world')
local paddle = require('entities/paddle')
local ball = require('entities/ball')
local boundary_bottom = require('entities/boundary-bottom')
local boundary_top = require('entities/boundary-top')
local boundary_left = require('entities/boundary-left')
local boundary_right = require('entities/boundary-right')

local frame = 0
local time = 0
local paused = false

love.draw = function()
    love.graphics.print("fps: " .. math.floor(frame / time), 0, 0)
    if paused then
        love.graphics.print("paused", 0, 10)
    end

    local ball_x, ball_y = ball.body:getWorldCenter()
    love.graphics.circle('fill', ball_x, ball_y, ball.shape:getRadius())
    love.graphics.polygon('line', paddle.body:getWorldPoints(paddle.shape:getPoints()))

    love.graphics.polygon('line', boundary_bottom.body:getWorldPoints(boundary_bottom.shape:getPoints()))
    love.graphics.polygon('line', boundary_top.body:getWorldPoints(boundary_top.shape:getPoints()))
    love.graphics.polygon('line', boundary_left.body:getWorldPoints(boundary_left.shape:getPoints()))
    love.graphics.polygon('line', boundary_right.body:getWorldPoints(boundary_right.shape:getPoints()))
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
