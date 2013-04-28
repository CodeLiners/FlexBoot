function fs_getUsedSpace(path)
	local totalsize = 0
	for i, file in ipairs(fs.list(path)) do
		if fs.isDir(path..'/'..file) then
			totalsize = totalsize + getUsedSpace(file) + 512
		else
			totalsize = totalsize + fs.getSize(file)
		end
	end
	return totalsize
end

function fs_getTotalSize(path)
	return fs.getFreeSpace(path) - getUsedSpace(path)
end