require("Classical")

-- Game Initial Variables

game = {
	win = {
		w = nil,
		h = nil,
		getDims = function(self) return self.w, self.h end,
	},
}

local function background()
	love.graphics.setColor(0.1,0.1,0.1)
	love.graphics.rectangle("fill",0,0,game.win.w,game.win.h)
	love.graphics.setColor(1,1,1)
end

function clamp(v,min,max)
	return (v > min and v < max and v) or (v > min and max) or (v < max and min)
end

-- Board

Board = Object:extend({
	new = function(self,w,h,rows,columns)
		self.w = w
		self.h = h
		self.tile.rows = rows
		self.tile.columns = columns

		self.x = game.win.w/2 - self.w/2
		self.y = game.win.h/2 - self.h/2

		self.tile.w = self.w/self.tile.rows
		self.tile.h = self.h/self.tile.columns
	end,
	tile = {},
})

function Board:draw()
	love.graphics.push()
		love.graphics.translate(self.x,self.y)
		for y=0,self.tile.columns,1 do
			for x=0,self.tile.rows,1 do
				love.graphics.rectangle("line",x*self.tile.w,y*self.tile.h,self.tile.w,self.tile.h)
			end
		end
	love.graphics.pop()
end

require("ChessPiece")

-- LOVE

function love.load()
	game.win.w, game.win.h = love.graphics:getDimensions()

	local bw = game.win.w/2
	bw = clamp(bw,0,game.win.h/2)
	game.board = Board(bw,bw,8,8)

	game.knight = ChessPiece(love.graphics.newImage("knight.png"))
	test = love.graphics.newImage("knight.png")
end

function love.update()
	game.knight:update()
end

function love.draw()
	background()
	game.board:draw()
	game.knight:draw()
end

function love.mousepressed(x,y,btn,touch,presses)
	game.knight:mousepressed(x,y)
end
