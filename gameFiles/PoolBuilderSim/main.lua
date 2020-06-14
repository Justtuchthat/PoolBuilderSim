require("inputHelper")

function love.load()
  buttonList = createButtonList()
  print("WOW")
end

function love.draw()
  buttonList = getInput(buttonList)
  printline = ""
  if buttonList.KPC.w.pressed then
    printline = printline .. "moving forward "
  end
  if buttonList.KPC.s.pressed then
    printline = printline .. "moving backward "
  end
  if buttonList.KPC.a.pressed then
    printline = printline .. "moving left "
  end
  if buttonList.KPC.d.pressed then
    printline = printline .. "moving right"
  end
  love.graphics.print(printline, 50, 50)
  love.graphics.print(buttonList.KPC.a.pressTime, 50, 100)
end

function love.update()

end
