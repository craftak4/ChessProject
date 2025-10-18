-- [ImportantPartMatchFunction] = ParserFunction
local parser = {
	[function(x) return x:match("\"(.*)\"") end] = function(x) return x end,
	[function(x) return x:match("^(%d*)$") end] = function(x) return tonumber(x) end,
}

-- Parses the `x`, ex. "123" to 123, or ""test"" to "test"
local function parse(x)
	-- Test all the parser on the value
	for matcher, parser in pairs(parser) do
		local match = matcher(x)
		if match then
			return parser(match)
		end
	end
end

-- Transfers data into variables with names
local function translateData()
	local data = game.data
	local result = {}
	result.knight = {}
	result.board = {}
	result.board.rows, result.board.columns = data[1][1],data[1][2]
	result.knight.x, result.knight.y = data[2][1],data[2][2]
	game.data = result
end


-- Loads data from the path, it should be CSV file
function game:loadData(path)
	local content = io.input(path):read()

	-- Elements for each line are parsed and inserted to row that is then inserted to data object. For ex. [["this", "is", "first", "row"], ["and", "this", "is", "second"]]
	for line in content:gmatch("([^\n]*)\n?") do
		local row = {}
		for element in line:gmatch("[ ,]?([^ ,]+)[ ,]?") do
			table.insert(row,parse(element))
		end
		table.insert(game.data,row)
	end

	translateData()
end

