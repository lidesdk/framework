-- ///////////////////////////////////////////////////////////////////
-- // Name:        lide/base/file.lua
-- // Purpose:     Filesystem framework
-- // Created:     2017/12/04
-- // Copyright:   (c) 2017 Hernan Dario Cano [dcanohdev@gmail.com]
-- // License:     GNU GENERAL PUBLIC LICENSE
-- ///////////////////////////////////////////////////////////////////

lide.file      = {}
lide.core.file = lide.file -- backward compatibility

-- Convert path to running OS
local function normalizePath ( path )
	if lide.platform.getOSName() == 'linux' then
		return path:gsub('\\', '/');
	elseif lide.platform.getOSName() == 'windows' then
		return path:gsub('/', '\\');
	end
end

-- backward compatibility
-- simple test to see if the file exits or not
function lide.file.doesExists( sFilename )
    lide.core.base.isstring(sFilename)
    local file = io.open(normalizePath(sFilename) , 'rb')
    if (file == nil) then return false end
    io.close(file)
    return true
end

--- [bool] file.does_exists ( string filePath )
function lide.file.does_exists ( filePath )
	return lide.file.doesExists( filePath )
end

function lide.file.exists ( filePath )
	return lide.file.doesExists(filePath)
end

function lide.file.delete ( file_path )
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

function lide.file.open ( strFilePath )
	return lide.classes.file (strFilePath);
end

function lide.file.remove ( ... )
	return lide.file.delete(...)
end


return lide.file