Player = AnimActor:extend()

function Player:new(winx, winy, winxx, winyy)
  Player.super.new(self, (winxx - winx) / 2, (winyy - winy) / 2, 300, 15, 15, 0, 0, 1)
  self.wini = Vector.new(winx or 0, winy or 0)
  self.winf = Vector.new(winxx or love.graphics.getWidth(), winyy or love.graphics.getHeight())
  self.cooldown = BTimer.new(0.25)
  self.wantToChangeGrav = false
  self.HasKey = false
end

function Player:destroy()
  self.body:destroy()
  self = nil
end

function Player:createOn(world)
  self.body = love.physics.newBody(world, self.wini.x + self.position.x, self.wini.y + self.position.y, "dynamic")
  self.body:setFixedRotation(true)
  self.shape = love.physics.newRectangleShape(self.size.x, self.size.y)
  self.fixture = love.physics.newFixture(self.body, self.shape, 0.5)
  self.fixture:setUserData("Player")
  self.fixture:setMask(2)
end

function Player:setWin(wini, winf)
  if self.wini ~= wini or self.winf ~= winf then
    self.wini = wini
    self.winf = winf
    self.body:setPosition(wini.x + self.position.x, wini.y + self.position.y)
  end
end

function Player:update(dt)
  if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
    self.body:applyForce(self.speed * self.speed * dt, 0)
  elseif love.keyboard.isDown("left") or love.keyboard.isDown("a") then
    self.body:applyForce(-self.speed * self.speed * dt, 0)
  end

  local xlv, ylv = self.body:getLinearVelocity()
  self.body:setInertia(0)
  self.body:setLinearVelocity(0, ylv * 3 / 4)
  self.cooldown:update(dt)
end

function Player:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end

function Player:SetSpawn(x, y)
  self.position.x = x
  self.position.y = y
  self.body:setPosition(self.wini.x + x , self.wini.y + y)
end

function Player:keyPressed(key)
  if key == "space" and not self.cooldown:isIterating() then
    self.cooldown:Start()
    self.wantToChangeGrav = true
  end
end
