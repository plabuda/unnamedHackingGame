local grid = require("grid")

function love.draw()
   grid.drawGrid(400,300,9,5)
   a, b = grid.getCoordinates(400, 300, love.mouse.getX(), love.mouse.getY())
   text = a .. " | " .. b
   love.graphics.print(text, 0, 0)
end