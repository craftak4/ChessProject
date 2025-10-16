require("Classical")
game = {}
game.win = {
	w = nil,
	h = nil,
	getDims = function(self) return self.w, self.h end,
}

Board = Object:extend({
	w = 200,
	h = 200,
	new = function(self)
		-- self.w, self.h = game.win:getDims()
		-- self.w, self.h = self.w*2/3, self.h*2/3
		self.x = game.win.w/2 - self.w/2
		self.y = game.win.h/2 - self.h/2

		self.tile.w = self.w/self.tile.rows
		self.tile.h = self.h/self.tile.columns
	end,
	tile = {
		w = 10,
		h = 10,
		rows = 8,
		columns = 8,
	}
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

function love.load()
	game.win.w, game.win.h = love.graphics:getDimensions()
	game.board = Board()
end

function love.update()

end

function love.draw()
	love.graphics.setColor(0.1,0.1,0.1)
	love.graphics.rectangle("fill",0,0,game.win.w,game.win.h)
	love.graphics.setColor(1,1,1)
	--game.board:draw()
	love.graphics.setColor(1,0,0)
	love.graphics.rectangle("fill",game.win.w/2,game.win.h/2,1,1)
end
