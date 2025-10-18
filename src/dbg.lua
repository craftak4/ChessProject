-- Debug table
dbg = {
	logs = {}
}

function dbg:record(i,v)
	self.logs[i] = v
end

function dbg:concat()
	local result = ""
	for i,v in pairs(self.logs) do
		result = result..", "..tostring(i).." = "..tostring(v)
	end
	return result
end

function dbg:draw()
	love.graphics.print(self:concat())
end
