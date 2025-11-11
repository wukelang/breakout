local state = require('state')

return function()
    local window_width, window_height = love.window.getMode()

    local entity = {}

    entity.draw = function(self)
        if state.paused and not (state.game_over or state.stage_cleared) then
            love.graphics.print(
                {state.palette[3], "PAUSED"}, 
                math.floor(window_width / 2) - 27, 
                math.floor(window_height / 2)
            )
        end
    end

    return entity
end
