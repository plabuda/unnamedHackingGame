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
return grid
