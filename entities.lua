-- Gameplay
local boundary_vertical = require('entities/boundary-vertical')
local boundary_horizontal = require('entities/boundary-horizontal')
local boundary_top = require('entities/boundary-top')
local boundary_bottom = require('entities/boundary-bottom')

local paddle = require('entities/paddle')
local ball = require('entities/ball')
local brick = require('entities/brick')
local brick_bomb = require("entities/brick-bomb")

-- UI
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
local window_width, window_height = love.window.getMode()
local row_brick_number = 8
local brick_width = 63
local brick_height = 23
local brick_row_width = row_brick_number * brick_width
local row_padding = window_width - brick_row_width

local brick_row_colors = { "red", "orange", "yellow", "green", "cyan" }

for i = 0, 39 do
    local row_num = math.floor((brick_width * i) / brick_row_width) + 1
    local brick_x = ((brick_width * i) % brick_row_width) + 180
    local brick_y = (row_num * brick_height) + 120
    -- print(row_num)
    -- print(brick_x, brick_y)

    -- if i ~= 36 then
    if i ~= 28 then
        table.insert(entities, 1, brick(brick_x, brick_y, brick_row_colors[row_num]))
    else
        table.insert(entities, 1, brick_bomb(brick_x, brick_y, brick_row_colors[row_num]))
    end
end

return entities
