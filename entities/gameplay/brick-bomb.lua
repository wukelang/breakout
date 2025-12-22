local world = require('world')
local textures = require('textures')
local sounds = require('sounds')  -- Move to base brick class
local brick = require('entities/gameplay/brick')

return function(x_pos, y_pos, color)
    local entity = brick(x_pos, y_pos, color)
    
    entity.image = textures.bomb
    

    entity.on_destroy = function(self)
        local x, y = entity.body:getPosition()
        -- print(x, y)

        -- Get nearby bricks and reduce health
        world:rayCast(x - 120, y, x + 60, y, worldRayCastCallback)
        world:rayCast(x - 120, y + 20, x + 60, y + 20, worldRayCastCallback)
        world:rayCast(x - 120, y - 20, x + 60, y - 20, worldRayCastCallback)

        sounds.bomb:play()
    end
    
    function worldRayCastCallback(fixture, x, y, xn, yn, fraction)
        local hit = {}
        hit.fixture = fixture
        hit.x, hit.y = x, y
        hit.xn, hit.yn = xn, yn
        hit.fraction = fraction

        local userdata = fixture:getUserData()
        if userdata.type == "brick" then
            userdata.health = userdata.health - 1
        end
        
        return 1 -- Continues with ray cast through all shapes.
    end

    return entity
end