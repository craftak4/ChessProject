require("Classical")
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
	tile = {}
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

ChessPiece = Object:extend({
	x = 0,
	y = 0,
	new = function(self,img)
		self.image = img
		self.w = game.board.tile.w
		self.h = game.board.tile.h
	end,
	pixel = {}
})

function ChessPiece:update()
	self.pixel.sw = 1/(self.image:getWidth()/self.w)
	self.pixel.sh = 1/(self.image:getHeight()/self.h)
	self.pixel.x = (game.board.x + game.board.tile.w * self.x)
	self.pixel.y = (game.board.y + game.board.tile.h * self.y)
end

function ChessPiece:draw()
	love.graphics.draw(self.image,self.pixel.x,self.pixel.y,0,self.pixel.sw,self.pixel.sh)
end

function love.load()
	game.win.w, game.win.h = love.graphics:getDimensions()

	game.board = Board(200,200/8*20,8,20)

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
