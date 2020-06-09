local grid = require("grid")

function love.draw()
   gridX, gridY = grid.getCoordinates(400, 300, love.mouse.getX(), love.mouse.getY())
   -- draw a triangle at calculated coordinates as a final test
   love.graphics.setColor(0,0.3,0.3)
   grid.drawTriangle(400, 300, gridX, gridY, "fill") 
   grid.drawGrid(400,300,9,5)
end