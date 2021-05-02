Desktop = Actor:extend()

function Desktop:new()
  Desktop.super.new(self, 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  self.menu = love.graphics.newImage("Textures/start_Icon.png")
  self.mousemoving = false
  self.mousestart = Vector.new(0, 0)
  self.sm = StartMenu(0, love.graphics.getHeight() - 26)
  local read = json.decode(love.filesystem.newFileData("data/desktop.json"):getString())
  self.desktop_objects = {}
  for _, k in ipairs(read) do
    table.insert(self.desktop_objects, DesktopIcon(k["x"], k["y"], k["name"], k["path"]))
  end
  read = nil
  self.processes = {}
  local winx2, winy2 = love.graphics.getWidth() / 2, love.graphics.getHeight() / 2
  table.insert(self.processes, WinP(winx2, winy2, winx2, winy2, love.window.getTitle()))
  -- for _,k in ipairs(self.desktop_objects) do
  --   print(k)
  --   for i, j in pairs(k) do print(i..j) end
  -- end
  -- table.insert(self.processes, DMenuBar(139))
  -- self.desIcon = DesktopIcon(36, 26)

end

function Desktop:update(dt)
  local x, y = love.mouse.getPosition()
  self.sm:update(dt)
  for _,k in ipairs(self.desktop_objects) do
    if love.mouse.isDown(1) then k:CheckPos(Vector.new(x, y)) end
    k:update(dt)
  end
  for _,k in ipairs(self.processes) do
    -- if love.mouse.isDown(1) then k:CheckPos(Vector.new(x, y)) end
    k:update(dt)
  end
end

function Desktop:draw()
  love.graphics.setColor(0.77,0.76,0.78)
  love.graphics.rectangle("fill", 0, love.graphics.getHeight() - 26, love.graphics.getWidth(), 26)
  love.graphics.setColor(1, 1, 1)
  love.graphics.line(0, love.graphics.getHeight() - 26, love.graphics.getWidth(), love.graphics.getHeight() - 26)
  love.graphics.setColor(0.77,0.76,0.78)
  love.graphics.line(0, love.graphics.getHeight() - 27, love.graphics.getWidth(), love.graphics.getHeight() - 27)
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.menu, 2, love.graphics.getHeight() - 24)

  self:Separator(58)
  self:Separator(128)
  for _,k in ipairs(self.desktop_objects) do
    k:draw()
  end
  for _,k in ipairs(self.processes) do
    k:draw()
  end
  self.sm:draw()
  -- self.desIcon:draw()
end

function Desktop:Separator(sx)
  love.graphics.setColor(0.52,0.51,0.52)
  love.graphics.line(sx + 1 , love.graphics.getHeight() - 23, sx + 1, love.graphics.getHeight() - 3)
  love.graphics.line(sx + 7, love.graphics.getHeight() - 21, sx + 7, love.graphics.getHeight() - 5, sx + 5, love.graphics.getHeight() - 5)
  love.graphics.setColor(1,1,1)
  love.graphics.line(sx + 2, love.graphics.getHeight() - 23, sx + 2, love.graphics.getHeight() - 3)
  love.graphics.line(sx + 5, love.graphics.getHeight() - 5, sx + 5, love.graphics.getHeight() - 21, sx + 6, love.graphics.getHeight() - 21)
end

function Desktop:keyPressed(key)
  for _,k in ipairs(self.processes) do
    k:keyPressed(key)
  end
end

function Desktop:mousepressed(x, y, button, presses)
  self.mousemoving = true
  self.mousestart.x, self.mousestart.y = x, y
  -- print(self.mousestart)
  if button == 1 and presses >= 2 then
    for _, k in ipairs(self.desktop_objects) do
      if k:CheckPos(self.mousestart) then
        k.isClicked = true
        table.insert(self.processes, Win(200, 200, 150, 150, "Test", nil, 305))
      else
        k.isClicked = false
      end
    end
  elseif button == 1 then
    self:StartIconBox(x, y)
    self.sm:IsAnyHovered(self.processes)
    for _,k in ipairs(self.processes) do if k:CheckPos(self.mousestart) then k.tempPos = self.mousestart end end
    for _,k in ipairs(self.desktop_objects) do if k:CheckPos(self.mousestart) then k.isClicked = true else k.isClicked = false end end
  end
end

function Desktop:StartIconBox(x, y)
  if x > 2 and x < 2 + self.menu:getWidth() and y > love.graphics.getHeight() - 24 and y < love.graphics.getHeight() then
    self.sm.isShown = not self.sm.isShown
  end
end

function Desktop:mousereleased(x, y, button, presses)
  self.mousemoving = false
  if button == 1 then
    for _,k in ipairs(self.processes) do if k.tempPos == self.mousestart then k.tempPos = Vector.new(0, 0) end end
    self.mousestart = Vector.new(0, 0)
  end
end
