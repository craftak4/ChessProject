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

function ChessPiece:mousepressed(x,y)
	local tx = clamp(math.floor((x - game.board.x)/game.board.tile.w),0,game.board.tile.rows)
	local ty = clamp(math.floor((y - game.board.y)/game.board.tile.h),0,game.board.tile.columns)
	local dx = math.abs(self.x - tx)
	local dy = math.abs(self.y - ty)
	if (dx == 1 and dy == 2) or (dx == 2 and dy ==1) then
		self.x, self.y = tx, ty
	end
end
