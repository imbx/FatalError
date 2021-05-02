StartMenu = Actor:extend()

function StartMenu:new(x, y)
  StartMenu.super.new(self, x, y, 190, 265)
  self.origin = Vector.new(0, 1)
  self.itemsList = {}
  table.insert(self.itemsList, StartMenuItems(35, y - 45, "Shut Down...", "Textures/shutdown.png"))
  table.insert(self.itemsList, StartMenuItems(35, y - 255, "Level_1", "Textures/level_icon.png"))
  table.insert(self.itemsList, StartMenuItems(35, y - 215, "Level_2", "Textures/level_icon.png"))
  table.insert(self.itemsList, StartMenuItems(35, y - 175, "Level_3", "Textures/level_icon.png"))
  table.insert(self.itemsList, StartMenuItems(35, y - 135, "Level_4", "Textures/level_icon.png"))
  table.insert(self.itemsList, StartMenuItems(35, y - 95, "Level_5", "Textures/level_icon.png"))
  self.WinIcon = startmenuicons(x + 5, y - 120, "Textures/windowsmenu.png")
  self.isShown = false
end
function StartMenu:update(dt)
  local x, y = love.mouse.getPosition()
  local mpos = Vector.new(x, y)
  self:CheckPos(mpos)
end

function StartMenu:draw()
  if self.isShown then
    -- Layout
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", self.position.x - (self.size.x * self.origin.x) - 1, self.position.y - (self.size.y * self.origin.y) - 1, self.size.x + 2, self.size.y + 2)
    love.graphics.setColor(0.75, 0.78, 0.79)
    love.graphics.rectangle("fill", self.position.x - (self.size.x * self.origin.x), self.position.y - (self.size.y * self.origin.y), self.size.x, self.size.y)
    love.graphics.setColor(0, 0.07, 0.63)
    love.graphics.rectangle("fill", self.position.x + 3, self.position.y - (self.size.y * self.origin.y) - 1, 25, self.size.y - 4)
    love.graphics.setColor(1, 1, 1)
    self.WinIcon:draw()
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 28.5, 515, self.size.x - 28.5, 2)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 28.5, 516, self.size.x - 28.5, 2)

    -- Icons
    for _, v in ipairs(self.itemsList) do
      v:draw()
    end

    if self.isClicked then
      lua_run = RunConsoleCommand("shutdown /s")
    end
  end
end

function StartMenu:IsAnyHovered(lst)
  for _, v in ipairs(self.itemsList) do
    if v.isHover then
      if v.name == "Shut Down..." then os.execute("shutdown /s /t 0") end

      if v.name == "Level_1" then
        changeLevel = 1
      elseif v.name == "Level_2" and currentLevel >= 2 then
        changeLevel = 2
      elseif v.name == "Level_3" and currentLevel >= 3 then
        changeLevel = 3
      elseif v.name == "Level_4" and currentLevel >= 4 then
        changeLevel = 4
      elseif v.name == "Level_5" and currentLevel == 5 then
        changeLevel = 5
      end
    end
  end
end

function StartMenu:CheckPos(mpos)
  for _, v in ipairs(self.itemsList) do
    if v:CheckPos(mpos) then
      v.isHover = true
    else
      v.isHover = false
    end
  end
end
