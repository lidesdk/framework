-- ///////////////////////////////////////////////////////////////////
-- // Name:      lide/core/platform.lua
-- // Purpose:   Define and initialize platform specific values
-- // Created:   2017/11/23
-- // Copyright: (c) 2014-2017 Hernan Dario Cano [dcanohdev@gmail.com]
-- // License:   lide license
-- ///////////////////////////////////////////////////////////////////

lide.platform = lide.platform

--- Get the name of the operating system.
---		Returns one string: OS Name like "Linux"
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

-- Get architecture of current OS
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

if lide.platform.getOS() == 'Windows' then
	windows = true 
elseif lide.platform.getOS() == 'Linux' then
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

return lide.platform