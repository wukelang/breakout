function love.load()
    -- image = love.graphics.newImage("cake.jpg")
    love.graphics.setColor(0,0,0)
    -- love.graphics.setBackgroundColor(255,255,255)
end

-- vertices = {100, 100, 100, 200, 200, 200, 200, 100}  -- Square
-- vertices = {400, 400, 500, 300, 600, 400}  -- Tri
-- vertices = {400, 400, 500, 300, 600, 400, 550, 500, 450, 500}  -- Pentagon
-- vertices = {100, 100, 100, 200, 200, 100, 200, 200}  -- Tie


current_color = {1, 1, 1, 1}
debug_color = {1, 1, 1, 1}

local key_map = {
    w = function()
        current_color = {1, 1, 1, 1}
    end,
    r = function()
        current_color = {1, 0, 0, 1}
    end,
    g = function()
        current_color = {0, 1, 0, 1}
    end,
    b = function()
        current_color = {0, 0, 1, 1}
    end,
    escape = function()
        love.event.quit()
    end
}

local frame = 1
local time_elapsed = 0
local input = ""
local debug = ""

function love.draw()
    love.graphics.setColor(current_color)
    -- love.graphics.polygon("fill", vertices)
    local square = {(time_elapsed * 10), 100, (time_elapsed * 10), 200, 200, 200, 200, 100}
    love.graphics.polygon("fill", square)

    love.graphics.setColor(debug_color)
    frame = frame + 1
    local time_display = "time_elapsed: " .. math.floor(time_elapsed)

    love.graphics.print({debug_color, frame})
    love.graphics.print({debug_color, time_display}, 0, 10)
    -- love.graphics.print({debug_color, debug}, 0, 10)
    love.graphics.print({debug_color, input}, 0, 20)

end


function love.keypressed(key)
    if key_map[key] then
        key_map[key]()
    end
end


function love.update(dt)
    time_elapsed = time_elapsed + dt
    -- print(dt)
end