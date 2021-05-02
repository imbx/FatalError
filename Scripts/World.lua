World = Actor:extend()
local PlayerIsDead, PlayerGotKey, HasEnded = false, false, false

function World:new(x, y, maxx, maxy, file, ply, lvln)
  World.super.new(self, x, y)
  self.levelN = lvln
  self.wini = Vector.new(x, y)
  self.winf = Vector.new(maxx, maxy)
  self.isDestroyed = false

  -- World

  self.world = love.physics.newWorld(0, 4096, true)
  self.world:setCallbacks(self.Cb, nil, nil)
  self:SetBounds(x, y, maxx, maxy)

  -- Player

  self.player = Player(self.wini.x, self.wini.y, self.winf.x, self.winf.y)
  self.player:createOn(self.world)

  -- UI

  self.ui = UI(self.wini.x, self.winf.y + 2, self.winf.x - self.wini.x, self.player.cooldown)

  -- Components
  self.components = {}
  self.key = nil
  self.endlvl = nil
  self.file = love.filesystem.newFileData(file)

  local read = json.decode(self.file:getString())
  for i, v in ipairs(read) do
    if v["type"] == "player" then
      local xg, yg = self.world:getGravity()
      self.world:setGravity(0, v["grav"] * yg)
      self.PlayerStartPos = Vector.new(v["x"], v["y"])
      self.player:SetSpawn(v["x"], v["y"], v["grav"])
    end
    if v["type"] == "wall" then
      table.insert(self.components, Block(self.world, v["x"], v["y"], v["sizex"], v["sizey"], self.position.x, self.position.y))
    end
    if v["type"] == "kill" then
      table.insert(self.components, DBlock(self.world, v["x"], v["y"], v["sizex"], v["sizey"], self.position.x, self.position.y))
    end
    if v["type"] == "key" then
      self.key = Key(self.world, v["x"], v["y"], self.position.x, self.position.y)
    end
    if v["type"] == "door" then
      self.endlvl = Barrier(self.world, v["x"], v["y"], v["sizex"], v["sizey"], self.position.x, self.position.y)
    end
  end
end

function World.Cb(self, cola, colb)
  if cola:getUserData() == "kill" then
    PlayerIsDead = true
  end
  if cola:getUserData() == "key" then
    PlayerGotKey = true
  end
  if cola:getUserData() == "barrier" then
    HasEnded = true
  end
end

function World:SetBounds(x, y, maxx, maxy)
  self.bbound = love.physics.newBody(self.world, x + ((maxx - x) / 2), y - 1)
  self.sbound = love.physics.newRectangleShape(maxx - x, 1)
  self.fbound = love.physics.newFixture(self.bbound, self.sbound)
  self.fbound:setUserData("Bound")
  self.bbound1 = love.physics.newBody(self.world, x + ((maxx - x) / 2), maxy + 1)
  self.sbound1 = love.physics.newRectangleShape(maxx - x, 1)
  self.fbound1 = love.physics.newFixture(self.bbound1, self.sbound1)
  self.fbound1:setUserData("Bound1")
  self.bbound2 = love.physics.newBody(self.world, x - 1, y + ((maxy - y) / 2))
  self.sbound2 = love.physics.newRectangleShape(1, maxy - y)
  self.fbound2 = love.physics.newFixture(self.bbound2, self.sbound2)
  self.fbound2:setUserData("Bound2")
  self.bbound3 = love.physics.newBody(self.world, maxx + 1, y + ((maxy - y) / 2))
  self.sbound3 = love.physics.newRectangleShape(1, maxy - y)
  self.fbound3 = love.physics.newFixture(self.bbound3, self.sbound3)
  self.fbound3:setUserData("Bound3")
end

function World:destroy()
  for _, v in ipairs(self.components) do
    v.body:destroy()
    v = nil
  end
  self.components = {}
  if self.player ~= nil then self.player:destroy() self.player = nil end
  if self.door ~= nil then self.door:destroy() self.door = nil end
  print(self.key == nil)
  if self.key ~= nil then self.key:destroy() self.key = nil end
  self.ui = nil
  self.world:destroy()
  self.world = nil

  -- if self.levelN == playingLevel then
    if currentLevel == playingLevel then
      playingLevel = playingLevel + 1
      changeLevel = playingLevel
      if currentLevel < 5 then currentLevel = playingLevel end
      if playingLevel == 6 then gamestate = "End" playingLevel = 1 end
    elseif currentLevel > playingLevel then
      playingLevel = playingLevel + 1
      changeLevel = playingLevel
    end
  -- end

  self.isDestroyed = true
end

function World:ModifyBound(x, y, maxx, maxy)
  if not self.isDestroyed then
    self.bbound:setPosition(x + ((maxx - x) / 2), y - 1)
    self.bbound1:setPosition(x + ((maxx - x) / 2), maxy + 1)
    self.bbound2:setPosition(x - 1, y + ((maxy - y) / 2))
    self.bbound3:setPosition(maxx + 1, y + ((maxy - y) / 2))
  end
end

function World:update(dt)
  local xg, yg = 0, 0
  -- if self.levelN ~= playingLevel then self:destroy() end
  if self.world ~= nil then xg, yg = self.world:getGravity() end

  if HasEnded then
    HasEnded = false
    if self.endlvl.key then
      self:destroy()
    end
  end
  if self.key ~= nil and self.endlvl ~= nil then
    if PlayerGotKey then
      print("Done")
      PlayerGotKey = false
      self.endlvl.key = true
      self.key:destroy()
      self.key = nil
    end
  end

  -- Player
  if self.player ~= nil then
    if PlayerIsDead then
      PlayerIsDead = false
      self.player:destroy()
      self.player = Player(self.wini.x, self.wini.y, self.winf.x, self.winf.y)
      self.player:createOn(self.world)
      if yg < 0 then self.world:setGravity(0, - yg) end
      self.player:SetSpawn(self.PlayerStartPos.x, self.PlayerStartPos.y)

    end

    if self.player.wantToChangeGrav then
      self.player.wantToChangeGrav = false
      self.world:setGravity(0, - yg)
      self.player.body:applyForce(0, 0.1)
    end

    self.player:update(dt)
  end

  -- Components

  for _, v in ipairs(self.components) do
    v:update(dt)
  end
  self:ModifyBound(self.wini.x, self.wini.y, self.winf.x, self.winf.y)

  -- UI
  if self.ui ~= nil then
    self.ui:update(dt)
    self.ui:setPos(self.wini.x, self.winf.y + 2)
  end

  -- World

  if self.world ~= nil then self.world:update(dt) end
end

function World:draw()
  for _, v in ipairs(self.components) do
    v:draw(self.position.x, self.position.y)
  end
  if self.key ~= nil then self.key:draw() end
  if self.endlvl ~= nil then self.endlvl:draw() end
  if self.player ~= nil then self.player:draw() end -- Player
  if self.ui ~= nil then self.ui:draw() end -- Cooldown Bar
end
