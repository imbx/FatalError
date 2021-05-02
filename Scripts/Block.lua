Block = Actor:extend()

function Block:new(world, x, y, sizex, sizey, winx, winy)
  Block.super.new(self, x, y, sizex, sizey)
  self.win = Vector.new(winx, winy)
  self.body = love.physics.newBody(world, winx + x, winy + y)
  self.shape = love.physics.newRectangleShape(sizex, sizey)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.fixture:setUserData("wall")
end

function Block:update(dt)
  self.body:setPosition(self.win.x + self.position.x, self.win.y + self.position.y)
end

function Block:draw(x, y)
  love.graphics.setColor(1, 1, 1)
  love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end
