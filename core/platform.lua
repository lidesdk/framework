-- ///////////////////////////////////////////////////////////////////
-- // Name:      lide/core/platform.lua
-- // Purpose:   Define and initialize platform specific values
-- // Created:   2017/11/23
-- // Copyright: (c) 2017-2018 Hernan Dario Cano [dcanohdev [at] gmail.com]
-- // License:   GNU GENERAL PUBLIC LICENSE
-- ///////////////////////////////////////////////////////////////////

--- Get the name of the operating system.
---		Returns one lowercase string: OS Name like "linux"
---
function lide.platform.get_osname ()
	if (package.config:sub(1,1) == '\\') and os.getenv 'OS' == 'Windows_NT' then
		return 'windows';
	elseif (package.config:sub(1,1) == '/') and io.popen 'uname -s':read '*l' == 'Linux' then
		return 'linux';
	else
		return 'other';
	end
end

---
-- Get the architecture of current binaries (OS)
--    string 'x86', 'x64', 'arm'
---
function lide.platform.get_osarch ()
	local _osname = lide.platform.get_osname():lower()

	if (_osname == 'windows') then
		return tostring(
			os.getenv 'PROCESSOR_ARCHITECTURE' 
			: gsub ('AMD64', 'x64')):sub(1,3);
	elseif (_osname == 'linux') then
		--- 
		-- Linux support contains: "x86", "x64" and "arm" architectures:
		---
		local uname_a = io.popen 'uname -m' : read '*a';
			
		if uname_a: find 'x86_64' then
			return 'x64';
		elseif uname_a: find 'i686' then
			return 'x86';
		elseif uname_a: find 'aarch64' then
			return 'arm64'
		elseif uname_a: find 'armv7l' then
			return 'arm32'			
		end
	end
end

function lide.platform.get_osversion ( rt_type )
	local _osname = lide.platform.get_osname():lower()

	if rt_type == 'string' then
		return io.popen 'wmic os get Caption':read ('*a'):delim'\n'[2];
	end

	if ('windows' == _osname) then
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
		error 'lide.platform.get_osversion not supported in Linux'
	end
end

local function normalize_path ( path )
	if lide.platform.get_osname() == 'windows' then
		return (path:gsub('/', '\\'));
	elseif lide.platform.get_osname() == 'linux' then
		return tostring(path:gsub('\\', '/'):gsub('//', '/'));
	end
end

lide.platform.normalize_path = normalize_path

---
-- backward compatibility:
---
lide.platform.getOSName     = lide.platform.get_osname    --from 0.1
lide.platform.getOSVersion  = lide.platform.get_osversion --from 0.1
lide.platform.getOSArch     = lide.platform.get_osarch --from 0.1
lide.platform.getOS         = lide.platform.get_osname --from 0.1
lide.platform.getArch       = lide.platform.get_osarch --from 0.1

return lide.platform