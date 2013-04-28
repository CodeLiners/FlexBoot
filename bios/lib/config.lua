local function serialize(tab, indent)
	local ret = ''
	for k, v in ipairs(tab) do
		if type(v) == 'table' then
			ret = ret..indent..'{\n'..serialize(v, indent..'    ')..indent..'},\n'
		elseif type(v) == 'boolean' or type(v) == 'number' then
			ret = ret..indent..tostring(v)..',\n'
		elseif type(v) == 'string' then
			ret = ret..indent..'"'..v:gsub('"','\\"')..'",\n'
		end		
		tab[k] = nil
	end 
	for k, v in pairs(tab) do
		if type(v) == 'table' then
			ret = ret..indent..k..' = {\n'..serialize(v, indent..'    ')..indent..'},\n'
		elseif type(v) == 'boolean' or type(v) == 'number' then
			ret = ret..indent..k..' = '..tostring(v)..',\n'
		elseif type(v) == 'string' then
			ret = ret..indent..k..' = "'..v:gsub('"','\\"')..'",\n'
		end
	end
	return ret
end

function config_export(tab)
	if not type(tab) == 'table' then
		error('Table expected, got '..type(tab), 2)
	end
	local ret = ''
	for k, v in pairs(tab) do
		if type(v) == 'table' then
			ret = ret..k..' = {\n'..serialize(v, '    ')..'}\n'
		elseif type(v) == 'boolean' or type(v) == 'number' then
			ret = ret..k..' = '..tostring(v)..'\n'
		elseif type(v) == 'string' then
			ret = ret..k..' = "'..v:gsub('"','\\"')..'"\n'
		end
	end
	return ret
end

function config_import(cfgstring)
	local cfgEnv = {}
	local cfgfunc, err = loadstring(cfgstring)
	setfenv( cfgfunc, cfgEnv )
	cfgfunc()
	return cfgEnv
end