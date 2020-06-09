local height = 86
local base = 100

local grid = {}

function grid.drawUpTriangle(cx, cy, w, h)
    love.graphics.line(cx - w/2, cy + h/2, cx, cy - h/2, cx + w/2, cy + h/2, cx - w/2, cy + h/2)
end

function grid.drawDownTriangle(cx, cy, w, h)
    love.graphics.line(cx - w/2, cy - h/2, cx + w/2, cy - h/2, cx, cy + h/2,  cx - w/2, cy - h/2)
end

function grid.drawTriangle(cx, cy, gridX, gridY)
    local x = cx + base/2 * gridX
    local y = cy + height * gridY
    local text = gridX .. "," .. gridY
    if (gridX + gridY) % 2 == 0 then
        grid.drawUpTriangle(x,y,base,height)
    else
        grid.drawDownTriangle(x,y,base,height)
    end
    love.graphics.print(text, x - 8, y-8)

end

function grid.drawGrid(cx, cy, w, h)
    love.graphics.setColor(1, 1, 1)
    local xMin = math.floor( w/2 ) * -1
    local xMax = w + xMin - 1

    local yMin = math.floor( h/2 ) * -1
    local yMax = h + yMin - 1

    for i=xMin,xMax do
        for j=yMin,yMax do
            grid.drawTriangle(cx, cy, i, j)
        end 
    end
end


function grid.getCoordinates(cx, cy, mx, my)
    local deltaX = mx - cx
    local deltaY = my - cy
    -- detect current row by simple rounding of the y coordinate, shifted by half a row height
    local gridY = math.floor( (deltaY + height/2) / height ) 

    -- Find a column of width equal to half of base. Finding this "sub-grid" coordinate
    -- will make final cell detection a trivial check comparison scaled x and y coordinates
    local subWidth = base / 2
    local subGridX =  math.floor( deltaX / subWidth ) 

    -- Find the top-left corner (origin) of current rextangle in the subGrid
    local oX = cx + (subGridX * subWidth)
    local oY = cy + (gridY * height) - height/2

    -- caluclate distances between the rectangle origin and mouse
    local deltaOX = mx - oX
    local deltaOY = my - oY
    
    --TODO flip x here based on type of line
    local shouldFlip = (subGridX + gridY) % 2 == 1
    if shouldFlip then
        deltaOX = subWidth - deltaOX
    end

    --scale the coordinates respectively and check which half the mouse is in
    local isAbove = deltaOX * height < deltaOY * subWidth

    -- now we can calculate the actual X location on the triangle grid
    local gridX = subGridX

    if shouldFlip == isAbove then
        gridX = gridX + 1
    end

    love.graphics.setColor(0.1, 0.0, 0.0)
    love.graphics.rectangle( "fill", oX, my - 300, subWidth, 600 )
    love.graphics.setColor(0.0, 0.1, 0.0)
    love.graphics.rectangle( "fill", mx - 300, oY, 600, height )
    if isAbove then 
        love.graphics.setColor(0.1, 0.1, 0.0)
    else
        love.graphics.setColor(0.3, 0.3, 0.0)
    end
    love.graphics.rectangle( "fill", oX, oY, subWidth, height)
    love.graphics.setColor(0.6, 0.6, 0.0)
    love.graphics.circle("fill", oX, oY, 7)



    return gridX, gridY
end


return grid
