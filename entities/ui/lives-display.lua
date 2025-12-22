local state = require('state')

return function(x_pos, y_pos)
    local entity = {}

    entity.draw = function(self)
        local text = "lives: " .. state.lives

        love.graphics.print(text, x_pos, y_pos)
    end

    return entity
end
