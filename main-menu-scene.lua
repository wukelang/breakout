local world = require('world')
local state = require('state')
local sounds = require('sounds')
local entity_manager = require('entity-manager')
local main_menu = require('entities/menu/main-menu')

local menu_entity = main_menu(1, 1)

local menu = {}

menu.reset_entities = function(self, entity_manager)
    entity_manager:clear()
    
    

end

menu.draw = function(self)
    entity_manager:draw()
    menu_entity:draw()
end

menu.update = function(self, dt)

    entity_manager:update(dt)

    world:update(dt)
end

return menu

