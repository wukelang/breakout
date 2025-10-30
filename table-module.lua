local my_cool_table = {}
my_cool_table.print_stuff = function()
  love.graphics.print('table-module.lua', 100, 200, 0, 2)
end

return my_cool_table