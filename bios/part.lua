--[[
    Partition code
]]

local _fs = fs

fs = {}
local parts, disks = {}, {}

------ LOADING -------

for k, v in ipairs(partconf.partitions) do
    parts[k] = v
end
-- TODO: load disks here
disks[1] = "/"

------ RESOLVING -------

local function resolve( disk, part, file )
    if not file:sub(1, 1) == "/" then file = "/"..file end
    return parts[disks[disk]]..part..file 
end