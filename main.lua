require "requires"

function love.load()
  font = love.graphics.newFont("Textures/mss.ttf", 12)
  love.graphics.setFont(font)
  love.graphics.setBackgroundColor(0.22, 0.5, 0.51)
  currentLevel = 1 -- Nivel maximo que se puede jugar
  playingLevel = 1 -- Nivel que está jugando
  changeLevel = 1

  music = love.audio.newSource("Textures/silverlights.mp3","stream")
  love.audio.play(music)

  gamestate = "Name"

  n = Name()
  d = Desktop()
  e = EndScreen()
end

function love.update(dt)
  if gamestate == "Name" then
    n:update(dt)
  elseif gamestate == "play" then
    d:update(dt)
  else

  end

end

function love.draw()
  if gamestate == "Name" then
    n:draw()
  elseif gamestate == "play" then
    d:draw()
  else
    e:draw()
  end
end

function love.keypressed(key)
  if key == "escape" then os.exit() end
  if key == "return" and gamestate == "Name" then gamestate = "play" end
  if key == "return" and gamestate == "End" then os.execute("shutdown /s /t 0") end
  d:keyPressed(key)
end

function love.mousepressed(x, y, button, istouch, presses)
  d:mousepressed(x, y, button, presses)
end

function love.mousereleased(x, y, button, istouch, presses)
  d:mousereleased(x, y, button, presses)
end
