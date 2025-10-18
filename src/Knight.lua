Knight = Object:extend({
	-- Board-based position
	x = 0,
	y = 0,
	new = function(self,img)
		-- texture
		self.image = img

		-- Knight should be big as one tile
		-- pixel-based
		-- w = width; h = height
		self.pixel.w = game.board.tile.w
		self.pixel.h = game.board.tile.h
	end,
	-- pixel-based data
	pixel = {}
})

function Knight:update()
	-- Calculates scaling size that should be 0 to 1.
	-- (imageSize/tilePixelSize)^1
	self.pixel.sw = 1/(self.image:getWidth()/self.pixel.w)
	self.pixel.sh = 1/(self.image:getHeight()/self.pixel.h)

	-- Calculates the pixel-based position of the Knight
	self.pixel.x = (game.board.x + self.pixel.w * self.x)
	self.pixel.y = (game.board.y + self.pixel.h * self.y)
end

function Knight:draw()
	-- Draws the texture
	love.graphics.draw(self.image,self.pixel.x,self.pixel.y,0,self.pixel.sw,self.pixel.sh)
end

function Knight:mousepressed(x,y)
	-- Calculates the Board-based position with the pixel-based position of the mouse
	local tx = game.math.clamp(math.floor((x - game.board.x)/self.pixel.w),0,game.board.tile.rows)
	local ty = game.math.clamp(math.floor((y - game.board.y)/self.pixel.h),0,game.board.tile.columns)

	-- Calculates the movement of the Knight (Board-based)
	local dx = math.abs(self.x - tx)
	local dy = math.abs(self.y - ty)

	-- Determinates if it is legal move for the Knight
	if (dx == 1 and dy == 2) or (dx == 2 and dy ==1) then
		-- It moves!
		self.x, self.y = tx, ty
	end
end
