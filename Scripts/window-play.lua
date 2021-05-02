WinP = Win:extend()

function WinP:new(x, y, resx, resy, name, icon)
  WinP.super.new(self, x, y, resx, resy, name, icon)

  local minx = (self.position.x - (self.realsize.x * self.origin.x)) + 1
  local miny = (self.position.y - ((self.realsize.y - 22) * self.origin.y)) + 2
  local maxx = (self.position.x + (self.realsize.x * self.origin.x)) - 1
  local maxy = (self.position.y + (self.realsize.y * self.origin.y + 3)) - 1


  if playingLevel == 1 then
    self.world = World(minx, miny, maxx, maxy, "data/level1.json", 1)
  elseif playingLevel == 2 then
    self.world = World(minx, miny, maxx, maxy, "data/level2.json", 2)
  elseif playingLevel == 3 then
    self.world = World(minx, miny, maxx, maxy, "data/level3.json", 3)
  elseif playingLevel == 4 then
    self.world = World(minx, miny, maxx, maxy, "data/level4.json", 4)
  elseif playingLevel == 5 then
    self.world = World(minx, miny, maxx, maxy, "data/level5.json", 5)
  end
  changeLevel = playingLevel

end

function WinP:update(dt)
  WinP.super.update(self, dt)
  if playingLevel ~= changeLevel then
    playingLevel = changeLevel
    self:new(self.position.x, self.position.y, self.size.x, self.size.y, self.name)
  end
  if not self.world.isDestroyed then
    self.world:ModifyBound((self.position.x - (self.realsize.x * self.origin.x)) + 1, (self.position.y - ((self.realsize.y - 22) * self.origin.y)) + 2, (self.position.x + (self.realsize.x * self.origin.x)) + 1, (self.position.y + ((self.realsize.y + 3) * self.origin.y)) + 1)
    self.world:update(dt)
  else
    print(playingLevel.. " " ..currentLevel)
    -- print(playingLevel.. " and has unlocked "..currentLevel)
    self:new(self.position.x, self.position.y, self.size.x, self.size.y, self.name)
  end
end

function WinP:draw()
  self.task:draw() -- Task Bar
  love.graphics.setColor(0, 0, 0) -- Black
  love.graphics.rectangle("fill", self.position.x - (self.size.x * self.origin.x), self.position.y - (self.size.y * self.origin.y), self.size.x, self.size.y) -- Bg
  love.graphics.setColor(1, 1, 1) -- White
  if not self.world.isDestroyed then self.world:draw() end-- Game
  WinP.super.DrawWin(self) -- Window
end

function WinP:CheckPos(mpos)
end

function WinP:keyPressed(key)
  if not self.world.isDestroyed then
    self.world.player:keyPressed(key)
  end
end
