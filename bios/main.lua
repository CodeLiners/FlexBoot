local requirecache = setmetatable({}, {__mode = "w"})

function require( lib )
    if requirecache[lib] then return requirecache[lib] end
    local lib_ = lib
    local env = setmetatable({}, {__index = _ENV})
    if (not nativefs.exists("/bios/lib/"..lib)) and nativefs.exists("/bios/lib/"..lib..".lua") then
        lib = lib..".lua"
    end
    local fn, err = loadfile("/bios/lib/"..lib)
    if not fn then 
        term.write("Lib error:")
        term.setCursorPos(1, 2)
        term.write(err)
        return nil
    end
    setfenv(fn, env)
    requirecache[lib_] = env
    local s, m = pcall(fn)
    if not s then 
        term.write("Lib error:")
        term.setCursorPos(1, 2)
        term.write(m)
        requirecache[lib_] = nil
        return nil
    end
    return env
end

partsys = require('part')
partsys.initpartitions()