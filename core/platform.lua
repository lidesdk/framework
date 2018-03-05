-- ///////////////////////////////////////////////////////////////////
-- // Name:      lide/core/platform.lua
-- // Purpose:   Define and initialize platform specific values
-- // Created:   2017/11/23
-- // Copyright: (c) 2017-2018 Hernan Dario Cano [dcanohdev [at] gmail.com]
-- // License:   GNU GENERAL PUBLIC LICENSE
-- ///////////////////////////////////////////////////////////////////

lide.platform = lide.platform

--- Get the name of the operating system.
---		Returns one lowercase string: OS Name like "linux"
---
--- string getOSVersion( nil )
function lide.platform.getOSName( ... )
	if (package.config:sub(1,1) == '\\') and os.getenv 'OS' == 'Windows_NT' then
		return 'windows';
	elseif (package.config:sub(1,1) == '/') and io.popen 'uname -s':read '*l' == 'Linux' then
		return 'linux';
	else
		return 'other';
	end
end

-- Get architecture of current binaries (OS)
-- string 'x86', 'x64'
function lide.platform.getArch ()
	local _osname = lide.platform.getOSName():lower()
	if (_osname == 'windows') then
		return tostring(os.getenv 'PROCESSOR_ARCHITECTURE' : gsub ('AMD64', 'x64')):sub(1,3);
	elseif (_osname == 'linux') then
		return io.popen 'uname -m' : read '*a' : gsub ('x86_64', 'x64') : gsub ( 'i686', 'x86' ):sub(1,3);
	end
end

lide.platform.getOS     = lide.platform.getOSName
lide.platform.getOSArch = lide.platform.getArch

if lide.platform.getOS() == 'windows' then
	windows = true 
elseif lide.platform.getOS() == 'linux' then
	linux = true
end

function lide.platform.getOSVersion ()
	if windows then
		-- because lide uses wxlua binaries compiled with utf8 decode...
		-- we should decode any string
		local winver = io.popen 'ver' : read '*a'
		local t = {} for w in string.gmatch(winver, "[%d]+") do -- only capture numbers
		    if tonumber(w) then
		   	   t[#t +1] = tonumber(w)
			end
		end
		
		return ('%d.%d.%d'):format(t[1], t[2], t[3])
	elseif linux then
		error 'lide.platform.getOSVersion not supported in Linux'
	end
end

local function normalize_path ( path )
	if lide.platform.getOSName() == 'windows' then
		return (path:gsub('/', '\\'));
	elseif lide.platform.getOSName() == 'linux' then
		return tostring(path:gsub('\\', '/'):gsub('//', '/'));
	end
end

lide.platform.get_osname     = lide.platform.getOSName
lide.platform.get_osversion  = lide.platform.getOSVersion
lide.platform.get_osarch     = lide.platform.getOSArch
lide.platform.normalize_path = normalize_path

return lide.platform