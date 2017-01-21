local memory = {}

local proxyTable = setmetatable({},
{
	__index = function(tbl, index)
		return memory[index]
	end,
	__newindex = function(tbl, index, value)
		memory[index] = value
	end,
})

return proxyTable
