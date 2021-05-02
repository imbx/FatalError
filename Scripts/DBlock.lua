DBlock = Actor:extend()

function DBlock:new(world, x, y, sizex, sizey, winx, winy)
  DBlock.super.new(self, x, y, sizex, sizey)
  self.win = Vector.new(winx, winy)
  self.body = love.physics.newBody(world, winx + x, winy + y)
  self.shape = love.physics.newRectangleShape(sizex, sizey)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.fixture:setUserData("kill")
end

function DBlock:update(dt)
  self.body:setPosition(self.win.x + self.position.x, self.win.y + self.position.y)
end

function DBlock:draw()
  love.graphics.setColor(1, 0, 0)
  love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end
