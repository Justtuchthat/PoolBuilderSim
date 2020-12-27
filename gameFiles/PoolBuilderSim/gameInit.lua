-- gameInit.lua
-- Created by Justtuchthat
-- first created on 10-8-2020
-- last edited on 18-10-2020
-- this is used for initiating the game

function initGame(gameSize)
  gameSize = gameSize or 100
  game = {}
  for x = 1, gameSize do
    game[x] = {}
    for y = 1, gameSize do
      game[x][y] = newGameCell()
    end
  end
  return game
end

function newGameCell()
  gameCell = {}
  gameCell.type = "grass"
  gameCell.inside = false
  return gameCell
end
