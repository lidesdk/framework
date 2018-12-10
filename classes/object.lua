-- ///////////////////////////////////////////////////////////////////
-- // Name:      lide/classes/object.lua
-- // Purpose:   Object class
-- // Created:   2014/08/24
-- // Copyright: (c) 2014-2018 Hernan Dario Cano [dcanohdev [at] gmail.com]
-- // License:   GNU GENERAL PUBLIC LICENSE
-- ///////////////////////////////////////////////////////////////////

local isString  = lide.core.base.isstring

-- define the class:
local Object = class 'Object' : global ( false )


function Object:Object ( sObjectName, nObjectID )
	local nObjectID = nObjectID or lide.core.base.newid ()
	
	-- Check if the args are the required type:
	assert(type(sObjectName) == 'string', 'Name of Object must be a string') ; assert(type(nObjectID) == 'number', 'ID of object must be numeric.')

	-- Define class values:
	protected {
		_objName = sObjectName,
		_objID   = nObjectID,
		
		ID   = nObjectID,
		Name = sObjectName,
	}


end


--- define class methods
---
--Object:virtual 'getID'
function Object:getID ()
	return self._objID
end

--Object:virtual 'setID'
function Object:setID ( nID )	
	self._objID = isNumber(nID) 

	if ( self._objID == nID ) then return true else return false end
end

Object:virtual 'getName'
function Object:getName ()
	return self._objName
end

-- default lua objects are read only named.
-- is possible to implement setName on lower level classes using:

	Object:virtual 'setName'
	function Object:setName ( sName )
		self._objName = lide.core.base.isstring(sName)
		self._objName = sName

		if ( self._objName == sName ) then return true else return false end
	end

--- define class meta-methods
---
function Object:__tostring ( )
	local str   = ('[%s: %s]')
	local stype = getmetatable(self).__type

	return str:format(stype or 'object', tostring(self._objName))
end

return Object