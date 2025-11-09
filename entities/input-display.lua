local input = require('input')

return function(x_pos, y_pos)
    local entity = {}

    entity.draw = function(self)
        local text = input.currentKey or ""

        love.graphics.print(text, x_pos, y_pos)
    end

    return entity
end
