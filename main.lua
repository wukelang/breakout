function love.load()
    -- image = love.graphics.newImage("cake.jpg")
    love.graphics.setColor(0,0,0)
    -- love.graphics.setBackgroundColor(255,255,255)
end

-- vertices = {100, 100, 100, 200, 200, 200, 200, 100}  -- Square
vertices = {400, 400, 500, 300, 600, 400}  -- Tri
-- vertices = {400, 400, 500, 300, 600, 400, 550, 500, 450, 500}  -- Pentagon
-- vertices = {100, 100, 100, 200, 200, 100, 200, 200}  -- Tie

selected_color = {1, 1, 1, 1}
colors = {
    ["b"] = {0, 0, 1, 1},
    ["g"] = {0, 1, 0, 1},
    ["r"] = {1, 0, 0, 1},
    ["w"] = {1, 1, 1, 1}
}
local frame = 1
local input = ""
local debug = ""

function love.draw()
    love.graphics.setColor(selected_color)
    love.graphics.polygon("line", vertices)

    
    frame = frame + 1
    love.graphics.print(frame)
    love.graphics.print(debug, 0, 100)
    love.graphics.print(input, 0, 200)

end


function love.keypressed(key)
    input = key

    if colors[key] ~= nil then
        -- love.graphics.setColor(colors[key])
        selected_color = colors[key]
        debug = table.concat(colors[key], ",")
    end


    if key == "escape" then
        love.event.quit()
    end
end
