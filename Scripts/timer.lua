BTimer = {}
BTimer.__index = BTimer

function BTimer.new(t)
  local tm = {
    time = t,
    ctime = t,
    pause = false
  }
  setmetatable(tm, BTimer)
  return tm
end

function BTimer:Start()
  self.ctime = 0
  self.pause = false
end

function BTimer:Pause()
  self.pause = true
end

function BTimer:Resume()
  self.pause = false
end

function BTimer:GetPercentage()
  return (self.ctime * 100) / self.time
end

function BTimer:isIterating()
  if self.time <= self.ctime or self.pause then return false end
  return true
end

function BTimer:update(dt)
  if self:isIterating() and not self.pause then
    self.ctime = self.ctime + dt
    -- print(self.ctime)
  end

  if self.ctime > self.time then
    -- print("END")
    self.ctime = self.time
  end
end

function BTimer:is(T)
  local mt = getmetatable(self)
  while mt do
    if mt == T then
      return true
    end
    mt = getmetatable(mt)
  end
  return false
end

function BTimer:__tostring()
  return "Timer"
end

function BTimer:__call(...)
  local obj = setmetatable({}, self)
  obj:new(...)
  return obj
end

return BTimer
