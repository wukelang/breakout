local state = require('state')
local textures = require('textures')

return function()
    local window_width, window_height = love.window.getMode()
    local entity = {}

    local text = "PAUSED"
    local font = textures.big_font
    local text_width = textures.big_font:getWidth(text)
    local text_height = textures.big_font:getHeight(text)
    local x = (window_width / 2) - (text_width / 2)
    local y = (window_height / 2) - text_height

    local subtext = "PRESS [SPACE] TO UNPAUSE"
    local subfont = textures.font
    local subtext_width = textures.font:getWidth(subtext)
    local subtext_height = textures.font:getHeight(subtext)
    local sub_x = (window_width / 2) - (subtext_width / 2)
    local sub_y = (window_height / 2) - subtext_height + 50

    entity.draw = function()
        if state.paused and not (state.game_over or state.stage_cleared) then

            love.graphics.print(text, font, x, y)

            love.graphics.print(subtext, subfont, sub_x, sub_y)
        end
    end

    return entity
end
