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

function File:File ( strFilePath, argOpen )
	isString(strFilePath);
	
	protected {
		_Lobj     = io.open(strFilePath, argOpen or 'rb'),
		_fullPath = strFilePath,
	}

	-- set object type on metatable:
	local mt = getmetatable(self)
	mt.__type = 'file'
	setmetatable(self, mt)
	--------------------------------
	
	self._objName = ( strFilePath )
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

function File:getFullPath ( ... )
	return self._fullPath
end

function File:read ( argOpen )
	self._Lobj:close() -- closes current file
	
	local localfile = io.open(self._fullPath, 'rb')
	local localfilecontent = localfile:read ( argOpen or '*all' );
	localfile:close()
	
	return localfilecontent
end

function File:write ( content )
	--self._Lobj:close() -- closes current file
	
	local localfile = io.open(self._fullPath, 'w+b')
	localfile:write( content ); localfile:close();

	local localfile = io.open(self._fullPath, 'rb')
	self._Lobj = localfile

	return (self._Lobj:read '*all' == content)
end

function File:close( ... )
	self._Lobj:close(...)
end

return File