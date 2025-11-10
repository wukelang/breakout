local boundary_horizontal = require('entities/boundary-horizontal')
local boundary_vertical = require('entities/boundary-vertical')

local paddle = require('entities/paddle')
local ball = require('entities/ball')
local brick = require('entities/brick')

local pause_text = require('entities/pause-text')
local input_display = require('entities/input-display')
local fps_display = require('entities/fps-display')

return {
    boundary_horizontal(400, 606),
    boundary_horizontal(400, -6),
    boundary_vertical(-6, 300),
    boundary_vertical(805, 300),
    paddle(300, 500),
    ball(300, 300),
    brick(50, 100),
    brick(100, 100),
    brick(150, 100),
    brick(200, 100),
    brick(300, 100),
    brick(400, 100),
    brick(500, 100),
    brick(600, 100),
    brick(700, 100),
    pause_text(),
    fps_display(0, 0),
    input_display(0, 10)
}
