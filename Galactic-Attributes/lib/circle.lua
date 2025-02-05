----------------------------------------------------------------------------------------
--circle.lua Makes shapes that user can move
----------------------------------------------------------------------------------------
local circle = {
	originalColor = { Red = 0, Green = 0, Blue = 0},
	hasAttribute = nil,
	inPosition = nil,
	"circle",
    "round",
    "radius",
    "circumference",
	"no vertices",
	"polygon"
}
local useAttributes = require "attributes"
--function createCircle displays circle object and initializes circle.hasAttrube
--based on currentAttribute in shapes.lua.
function circle.createCircle( x, y, rad, currentAttribute )
	x = x or display.contentCenterX
	y = y or display.contentCenterY
    rad = rad or 150
    aCircle = display.newCircle( x, y, rad )		--x-coordinate, y-coordinate, radius
	Red = 0
	Green = 0
	Blue = 150
	circle.originalColor.Red = Red
	circle.originalColor.Green = Green
	circle.originalColor.Blue = Blue
	aCircle:setFillColor( Red, Green, Blue )      -- fill the circle with color
	aCircle.strokeWidth = 0.016 * display.contentWidth   -- Sets the width of the border of circle
	--Set Stroke color
	aCircle:setStrokeColor( 128, 0, 128 )    -- Sets the border color
    aCircle:addEventListener( "touch", circle.move )
    aCircle.alpha = 0.7 --circle opacity 
	--check if cirlce has attributes.currentAttribute (in attributes.lua table)
	print( "Checking Circle Attributes" )
	local test = false
    for index, attribute in ipairs(circle) do
        print("checking ", index, attribute)
        if attribute == currentAttribute then
            test = true
            print("true")
        end
	end
	circle.hasAttribute = test
    --initialize attributes.hasAttribute if no value set it to true
    return aCircle
end --createCircle function
--Move shapes function
function circle.move( event )
    --eventt.target comes from EventListener and is the object the "touch" is targeting
	local object = event.target
    local touchDistance = object.width
	--Move shape
	if math.abs( object.x - event.x ) < touchDistance and math.abs( object.y - event.y ) < touchDistance then
		object.x = event.x
		object.y = event.y
    end
    --Change color if circle is in position and has attribute
	if useAttributes.isShapeWithinRadius( object, .85 * display.contentCenterX, display.contentCenterX, display.contentCenterY) then
        if circle.hasAttribute then
			--change color to green
			object:setFillColor( 0, 128 , 0)
		else
			--change color to red
			object:setFillColor( 128, 0 , 0 )
		end
		circle.inPosition = true
	else
		object:setFillColor( circle.originalColor.Red, circle.originalColor.Green, circle.originalColor.Blue )
		circle.inPosition = false
	end 
end --end move function
return circle
