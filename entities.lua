local boundary_vertical = require('entities/boundary-vertical')
local boundary_horizontal = require('entities/boundary-horizontal')
local boundary_top = require('entities/boundary-top')
local boundary_bottom = require('entities/boundary-bottom')

local paddle = require('entities/paddle')
local ball = require('entities/ball')
local brick = require('entities/brick')

local pause_text = require('entities/pause-text')
local game_over_text = require('entities/game-over-text')
local stage_clear_text = require('entities/stage-clear-text')
local input_display = require('entities/input-display')
local fps_display = require('entities/fps-display')

local entities = {
    boundary_bottom(400, 606),
    boundary_top(400, -6),
    boundary_vertical(-6, 300),
    boundary_vertical(805, 300),
    paddle(300, 500),
    ball(300, 300),
    pause_text(),
    game_over_text(),
    stage_clear_text(),
    fps_display(0, 0),
    input_display(0, 10)
}

local row_width = love.window.getMode() - 20
local row_height = 40
local brick_width = 60

for i = 0, 38 do 
    local brick_x = ((brick_width * i) % row_width) + 40
    local brick_y = (math.floor((brick_width * i) / row_width) * row_height) + 80
    table.insert(entities, 1, brick(brick_x, brick_y))
end

return entities
