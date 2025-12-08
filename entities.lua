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
local lives_display = require('entities/lives-display')

local entities = {
    boundary_bottom(400, 800),  -- Slightly offscreen.
    boundary_top(400, -6),
    boundary_vertical(-6, 300),
    boundary_vertical(805, 300),
    paddle(300, 500),
    ball(300, 300),
    pause_text(),
    game_over_text(),
    stage_clear_text(),
    fps_display(0, 10),
    input_display(0, 20),
    lives_display(0, 0)
}

-- Refactor to use width/height from brick entity
local row_width = love.window.getMode() - 200
local row_height = 20
local brick_width = 60

for i = 0, 39 do 
    local brick_x = ((brick_width * i) % row_width) + 130
    local brick_y = (math.floor((brick_width * i) / row_width) * row_height) + 120
    -- print(brick_x, brick_y)
    table.insert(entities, 1, brick(brick_x, brick_y))
end

return entities
