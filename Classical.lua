-- Classical starts on line 152

-- ================================
--	     TableUtils
--
-- 	CREATED BY CODERIX CYAN
-- 	  [ CYAN DEVELOPERS ]
--
-- --------------------------------
-- See the license in the LICENSE
-- ================================


-- ACTIONS

function table.removeWhere(tbl, predicate)
	for i,v in pairs(tbl) do
		if predicate(i,v) then
			if type(i) == "number" then
				table.remove(tbl,i)
			else
				tbl[i] = nil
			end
		end
	end
	return tbl
end

function table.removeValue(tbl, value)
	table.removeWhere(tbl,function(x) return x == value end)
	return tbl
end

function table.reverse(tbl)
	table.sort(tbl,function(x,y) return x > y end)
	return tbl
end

function table.copy(a,b)
	for i,v in pairs(a) do
		b[i] = v
	end
	return b
end


function table.constTable(tbl)
	local constants = {}
	constants.const = function(i,v) constants[i] = v end
	local meta = { __index = constants, __newindex = function(t,i,v) if not constants[i] then rawset(t,i,v) end end }
	setmetatable(meta,getmetatable(tbl))
	setmetatable(constants,getmetatable(tbl))
	setmetatable(tbl,meta)
	return tbl
end


-- QUERIES

function table.count(tbl)
	return #tbl
end

function table.indexOf(tbl, value)
	for i,v in pairs(tbl) do
		if v == value then
			return i
		end
	end
	return -1
end

function table.contains(tbl,index,value)
	for i, v in pairs(tbl) do
		if i == index then
			return true
		end
		if v == value then
			return true
		end
	end
	return false
end

function table.equals(a,b)
	if #a ~= #b then
		return false
	end
	for i, v in pairs(a) do
		if b[i] ~= v then
			return false
		end
	end
	return true
end

function table.keys(tbl)
	local result = {}
	for i,_ in pairs(tbl) do
		table.insert(result,i)
	end
	return result
end

function table.values(tbl)
	local result = {}
	for _,v in pairs(tbl) do
		table.insert(result,v)
	end
	return result
end


-- ITERATORS

function table.first(tbl, predicate)
	for i, v in pairs(tbl) do
		if predicate(i,v) then
			return v
		end
	end
	return nil
end

function table.where(tbl, predicate)
	local r = {}
	for i, v in pairs(tbl) do
		if predicate(i,v) then
			table.insert(r,v)
		end
	end
	return r
end

function table.select(tbl, func)
	local result = {}
	for i,v in pairs(tbl) do
		result[i] = func(i,v)
	end
	return result
end

function table.asReadOnly(tbl)
	local new = {}
	local meta = { __index = tbl, __newindex = function(t,i,v) end }
	setmetatable(meta,getmetatable(tbl))
	setmetatable(new,meta)
	return new
end

-- ================================
-- 	     Classical
--
-- 	CREATED BY CODERIX CYAN
-- 	[ CYAN DEVELOPERS ]
--
-- Improved rxi/classic (see the CHANGELOG.md for changes)
-- --------------------------------
-- See the license in the LICENSE
-- ================================

Object = {}
Object.__index = Object


function Object:new()
end


function Object:extend(cls)
  for k, v in pairs(self) do
    if k:find("__") == 1 then
      cls[k] = v
    end
  end
  cls.__index = cls
  cls.super = self
  setmetatable(cls, self)
  return cls
end


function Object:implement(...)
  for _, cls in pairs({...}) do
    for k, v in pairs(cls) do
      if self[k] == nil and type(v) == "function" then
        self[k] = v
      end
    end
  end
end

function Object:is(T)
  local mt = getmetatable(self)
  while mt do
    if mt == T then
      return true
    end
    mt = getmetatable(mt)
  end
  return false
end


function Object:__tostring()
  return "Object"
end

function Object:__call(...)
  local obj = setmetatable({}, self)
  obj:new(...)
  local EmptyFunc = function() end
  table.copy({fromToml = EmptyFunc, new = EmptyFunc, extend = EmptyFunc, implement = EmptyFunc},obj)
  return obj
end

-- local function 
-- 
-- function Object:fromToml()
-- 
-- end
