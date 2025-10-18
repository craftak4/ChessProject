-- [ChessProject] - By VK

-- Package with table utility functions and makes tables more object-oriented
require("Classical")

-- Function that prepares my comfortable favourite background
local function background()
	love.graphics.setColor(0.1,0.1,0.1)
	love.graphics.rectangle("fill",0,0,game.win.w,game.win.h)
	love.graphics.setColor(1,1,1)
end

-- All data and variables of whole game
game = {
	win = {
		-- w = width; h = height
		w = nil,
		h = nil,
		getDims = function(self) return self.w, self.h end,
	},
	-- Data that are fetched from the data file - see game:loadData
	data = {},

	-- Utility functions for math
	math = {},
}

-- Table for debugging object that records values of variable and then prints
require("dbg")

-- Table for loading data (initial parameters)
require("data")



-- [ Math ]
-- Chooses biggest number
function game.math.max(x,y)
	return x > y and x or y
end

-- Chooses lowest number
function game.math.min(x,y)
	return x > y and y or x
end

-- Clamp function, chooses `v` if it is less than `maxNum` and bigger than `minNum` - if not, `v` will equal to `maxNum` or `minNum`, depending if it is less or bigger
function game.math.clamp(v,minNum,maxNum)
	return game.math.max(game.math.min(v,minNum),maxNum)
end



-- The Board
Board = Object:extend({
	-- Constructor
	-- self=board; w = width; h = height 
	new = function(self,w,h,rows,columns)
		-- Pixel-based width and height of the board
		self.w = w
		self.h = h

		-- Number of rows and columns of tiles in the board
		self.tile.rows = rows
		self.tile.columns = columns

		-- Calculates the pixel-based coordinates to make it centered depending on the size
		self.x = game.win.w/2 - self.w/2
		self.y = game.win.h/2 - self.h/2

		-- Calculates the pixel-based size of each tile
		self.tile.w = self.w/self.tile.rows
		self.tile.h = self.h/self.tile.columns
	end,
	-- Data of tile
	tile = {},
})

-- Drawing function of the Board
function Board:draw()
	-- Isolates the current transform situation - push [isolation] pop
	love.graphics.push()
		-- Moves all currently-drawed elements inside the board
		love.graphics.translate(self.x,self.y)

		-- Draws all the tiles
		for y=0,self.tile.columns-1,1 do
			for x=0,self.tile.rows-1,1 do
				love.graphics.rectangle("line",x*self.tile.w,y*self.tile.h,self.tile.w,self.tile.h)
			end
		end
	love.graphics.pop()
end

-- Loads Knight.lua - the knight
require("Knight")

-- LOVE

function love.load()
	-- Fetches data of window
	game.win.w, game.win.h = love.graphics:getDimensions()

	-- Loads the game data
	game:loadData("data.csv")

	-- Calculates the comfortable size of Board depending on device size
	dbg:record("winX",game.win.w)
	dbg:record("winY",game.win.h)

	local rows = game.data.board.rows
	local columns = game.data.board.columns

	local sizeX = game.win.w/2
	dbg:record("sizeX initial",sizeX)
	local sizeY = game.math.clamp((sizeX/columns) * rows,0,game.win.h/2)
	dbg:record("sizeY",sizeY)
	sizeX = sizeY/rows * columns

	-- Constructs the board
	game.board = Board(300,600,game.data.board.rows,game.data.board.columns)

	-- Constructs the knight
	game.knight = Knight(love.graphics.newImage("knight.png"))
	test = love.graphics.newImage("knight.png")
end

function love.update()
	game.knight:update()
end

function love.draw()
	background()

	game.board:draw()
	game.knight:draw()

	dbg:draw()
end

function love.mousepressed(x,y,btn,touch,presses)
	game.knight:mousepressed(x,y)
end
