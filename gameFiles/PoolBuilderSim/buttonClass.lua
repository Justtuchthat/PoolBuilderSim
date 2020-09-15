-- buttonClass.lua
-- created by Justtuchthat
-- first created on 10-09-2020
-- last edited on 15-09-2020
-- this is the class that will contain all buttons

allButtons = {}

function newButton(type, loc, face, color)
  if not type then love.errhand("No button Type when creating button") end
  if not loc then love.errhand("No button location when creating button") end
  if not face then love.errhand("No button face when creating button") end
  mode = mode or "topLeft"
  local newButton = {}
  newButton.type = type
  newButton.loc = loc
  newButton.disabled = true
  newButton.size = {}
  if type == "text" then
    newButton.face = love.graphics.newText(love.graphics.newFont(), face)
    newButton.color = color
    newButton.size.x, newButton.size.y = newButton.face:getDimensions()
    newButton.size.x = newButton.size.x + 4
  elseif type == "image" then
    newButton.face = love.graphics.newImage(face)
    newButton.size.x, newButton.size.y = newButton.face:getDimensions()
  else
    love.errhand("Wrong button type : " .. type)
  end

  newButton.pressAction = {}
  newButton.pressAction.addFunction = function(self, Fn)
    table.insert(self, Fn)
  end
  newButton.hasCursorInside = function(self, mouse)
    return mouse.x >= self.loc.x and mouse.y >= self.loc.y and
    mouse.x < self.loc.x + self.size.x and mouse.y < self.loc.y + self.size.y
  end
  newButton.draw = function(self)
    if not self.disabled then
      if self.type == "text" then
        love.graphics.setColor(self.color)
        love.graphics.rectangle("fill", self.loc.x, self.loc.y, self.size.x, self.size.y, 2, 2)
        love.graphics.setColor({0, 0, 0})
        love.graphics.draw(self.face, self.loc.x + 2, self.loc.y)
      elseif self.type == "image" then

      end
    end
  end
  table.insert(allButtons, newButton)
  return newButton
end

local function mousePressForButtons(Keyboard, mouse)
  for i, btn in ipairs(allButtons) do
    if (not btn.disabled) and btn:hasCursorInside(mouse) then
      for i, Fn in ipairs(btn.pressAction) do
        Fn()
      end
      return
    end
  end
end

local function setupMouse()
  mouse.button[1].releaseAction:addFunction(mousePressForButtons)
end

function startButtonClass()
  setupMouse()
end

function renderButtons()
  for i, btn in ipairs(allButtons) do
    btn:draw()
  end
end
