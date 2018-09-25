--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class{}

function GameObject:init(def, x, y)
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    self.defaultState = def.defaultState 
    self.state = self.defaultState
    self.states = def.states

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    self.randomTile = def.randomTile or false

    if self.randomTile then
        self.tileId = rnd(3)
    end

    -- default empty collision callback
    self.onCollide = function() end
end

function GameObject:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function GameObject:update(dt)

end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)

    if not self.randomTile then
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
            self.x + (adjacentOffsetX or 0), self.y + (adjacentOffsetY or 0))
    else
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame[self.tileId] or self.frame],
        self.x + (adjacentOffsetX or 0), self.y + (adjacentOffsetY or 0))
    end

        --[[
    love.graphics.setColor(255, 0, 255, 255)
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    love.graphics.setColor(255, 255, 255, 255)
    ]]
end