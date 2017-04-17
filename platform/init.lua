lide.platform = lide.platform
lide.platform.__arch = os.getenv 'PROCESSOR_ARCHITECTURE' 
					   or io.popen 'uname -m' : read '*a' : gsub ('x64_64', 'x64') : gsub ( 'i686', 'x86' )

function lide.platform.getArch ()
	return lide.platform.__arch
end

lide.platform.getOS = lide.platform.getOSName

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