local world = love.physics.newWorld(0, 100)

local triangle = {}
triangle.body = love.physics.newBody(world, 200, 200, 'dynamic')
triangle.body:setMass(32)
triangle.shape = love.physics.newPolygonShape(100,100, 200,100, 200,200)
triangle.fixture = love.physics.newFixture(triangle.body, triangle.shape)

local bar = {}
bar.body = love.physics.newBody(world, 200, 450, 'static')
bar.shape = love.physics.newPolygonShape(0,0, 0,20, 400,20, 400,0)
bar.fixture = love.physics.newFixture(bar.body, bar.shape)

frame = 0
time = 0

love.draw = function()
    love.graphics.print("fps: " .. math.floor(frame / time), 0, 0)
    love.graphics.polygon('line', triangle.body:getWorldPoints(triangle.shape:getPoints()))
    love.graphics.polygon('line', bar.body:getWorldPoints(bar.shape:getPoints()))
end

love.update = function(dt)
    frame = frame + 1
    time = time + dt


    world:update(dt)

    -- print(triangle.body:getWorldPoints(triangle.shape:getPoints()))
    -- print(triangle.shape:getPoints())
end

local keymap = {
    escape = function()
        love.event.quit()
    end
}

love.keypressed = function(key)
    if keymap[key] then
        keymap[key]()
    end
end
