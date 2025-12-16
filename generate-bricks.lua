local brick = require('entities/brick')
local brick_bomb = require("entities/brick-bomb")

return {
    generate_bricks = function()
        -- Refactor to use width/height from brick entity
        local bricks = {}
        
        local window_width, window_height = love.window.getMode()
        local row_brick_number = 8
        local brick_width = 63
        local brick_height = 23
        local brick_row_width = row_brick_number * brick_width
        local row_padding = window_width - brick_row_width

        local brick_row_colors = { "red", "orange", "yellow", "green", "cyan" }

        -- for i = 0, 39 do
        for i = 0, 7 do
            local row_num = math.floor((brick_width * i) / brick_row_width) + 1
            local brick_x = ((brick_width * i) % brick_row_width) + 180
            local brick_y = (row_num * brick_height) + 120
            -- print(row_num)
            -- print(brick_x, brick_y)

            -- if i == 28 or i == 12 or i == 20 or i == 26 or i == 34 or i == 27 then
            -- if i % 2 == 0 then
            -- if true then
            --     table.insert(bricks, 1, brick_bomb(brick_x, brick_y, brick_row_colors[row_num]))
            -- else
            --     table.insert(bricks, 1, brick(brick_x, brick_y, brick_row_colors[row_num]))
            -- end
            table.insert(bricks, 1, brick(brick_x, brick_y, brick_row_colors[row_num]))
        end

        return bricks
    end
}
