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

    love.graphics.setColor(0.1, 0.0, 0.0)
    love.graphics.rectangle( "fill", cx + (subGridX * subWidth), my - 300, subWidth, 600 )
    love.graphics.setColor(0.0, 0.1, 0.0)
    love.graphics.rectangle( "fill", mx - 300, cy + (gridY * height) - height/2, 600, height )
    love.graphics.setColor(0.1, 0.1, 0.0)
    love.graphics.rectangle( "fill", cx + (subGridX * subWidth), cy + (gridY * height) - height/2, subWidth, height)
    return subGridX, gridY
end


return grid
