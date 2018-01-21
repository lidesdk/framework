-- ///////////////////////////////////////////////////////////////////
-- // Name:        lide/base/file.lua
-- // Purpose:     Filesystem framework
-- // Created:     2017/12/04
-- // Copyright:   (c) 2017 Hernan Dario Cano [dcanohdev@gmail.com]
-- // License:     Lide framework license
-- ///////////////////////////////////////////////////////////////////
--

lide.core.file = { }

-- Convert path to running OS
local function normalizePath ( path )
	if lide.platform.getOSName() == 'linux' then
		return path:gsub('\\', '/');
	elseif lide.platform.getOSName() == 'windows' then
		return path:gsub('/', '\\');
	end
end

-- simple test to see if the file exits or not
function lide.core.file.doesExists( sFilename )
    lide.core.base.isstring(sFilename)
    local file = io.open(normalizePath(sFilename) , 'rb')
    if (file == nil) then return false end
    io.close(file)
    return true
end

function lide.core.file.delete ( file_path )
	local _shell_command
	
	if lide.platform.getOSName() == 'linux' then
		_shell_command = 'rm -rf "%s"'
	elseif lide.platform.getOSName() == 'windows' then
		_shell_command = 'del /F /Q /S "%s"'
	end
	
	local exc, err = pcall(
		io.popen, _shell_command:format(normalizePath(file_path), 'rb')
	) 

	if not exc then
		print ('error: '.. err)
	end
end

lide.file      = lide.core.file
lide.base.file = lide.file

function lide.file.remove ( ... )
	lide.core.file.delete(...)
end

return lide.core.file