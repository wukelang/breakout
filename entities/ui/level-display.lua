local state = require('state')

return function(x_pos, y_pos)
    local entity = {}
    local level = state.level or "N/A"
    local speed = state.speed or "N/A"

    entity.draw = function(self)
        local level_text = "level: " .. level
        local speed_text = "speed: " .. speed
        love.graphics.print(level_text, x_pos, y_pos)
        -- love.graphics.print(speed_text, x_pos, y_pos + 10)
    end

    entity.update = function(self, dt)
        level = state.level or "N/A"
        speed = state.speed or "N/A"
    end

    return entity
end
