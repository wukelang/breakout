
local entity_manager = {}

entity_manager.entities = {}

function entity_manager:new()
    local instance = setmetatable({}, self)
    instance.entities = {}
    return instance
end

function entity_manager:add(entity)
    table.insert(self.entities, entity)
    return entity
end

function entity_manager:add_list(entity_list)
    for _, entity in ipairs(entity_list) do
        entity_manager:add(entity)
    end
end

function entity_manager:update(dt)
    local index = 1
    -- print(#entities)
    while index <= #self.entities do
        -- print("?")
        local entity = self.entities[index]

        if entity.update then entity:update(dt) end

        if entity.health and entity.health < 1 then
            table.remove(self.entities, index)
            if entity.on_destroy then entity.on_destroy() end
            entity.fixture:destroy()
        else
            index = index + 1
        end
    end
end

function entity_manager:draw()
    for _, entity in ipairs(self.entities) do
        if entity.draw then entity:draw() end
    end
end

function entity_manager:clear()
    for _, entity in ipairs(self.entities) do
        if entity.fixture ~= nil then
            entity.fixture:destroy()
        end
    end

    self.entities = {}
end


return entity_manager