-- /////////////////////////////////////////////////////////////////////////////
-- // Name:        lide/classes/file.lua
-- // Purpose:     File class
-- // Author:      Hernan Dario Cano [dcanohdev@gmail.com]
-- // Created:     07/08/2017
-- // Copyright:   (c) 2014 - 2017 Hernan Dario Cano
-- // License:     GNU GENERAL PUBLIC LICENSE
-- /////////////////////////////////////////////////////////////////////////////
--
-- Class constructor:
--
--  object File:new ( string filePath )
--
--  	string filePath		The object name
--

-- import local classes:
local Object   = lide.classes.object

-- import functions:
local isString = lide.core.base.isstring

-- define the class:
local File = class 'File' : subclassof 'Object'

function File:File ( strFilePath )
	isString(strFilePath);
	
	self.lobj = io.open(strFilePath, 'w+b')
	self._fullPath = strFilePath
end

function File:getFolder ( ... )
	local splitPath = { string.match(self._fullPath, "(.-)([^\\/]-%.?([^%.\\/]*))$") }
	
	return splitPath [1]:sub(1, #splitPath[1] -1)
end

function File:getFilename ( ... )
	local splitPath = { string.match(self._fullPath, "(.-)([^\\/]-%.?([^%.\\/]*))$") }
	
	return splitPath [2]
end

function File:getExtension (	)
	local splitPath = { string.match(self._fullPath, "(.-)([^\\/]-%.?([^%.\\/]*))$") }

	return splitPath[3]
end

function File:__tostring ( ... )
	return tostring(self._fullPath)
end

function File:getFullPath ( ... )
	return self._fullPath
end

function File:read ( ... )
	return self.lobj:read(...)
end

function File:write ( content )
	self.lobj:write( content )
end

function File:close( ... )
	self.lobj:close(...)
end

setmetatable(lide.file, { 
	__call = function ( self, ... )
	   return File (...)
	end
});

return File