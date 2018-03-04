-- ///////////////////////////////////////////////////////////////////
-- // Name:      lide/core/oop/init.lua
-- // Purpose:   OOP Initialization
-- // Created:   2016/01/03
-- // Copyright: (c) 2016-2018 Hernan Dario Cano [dcanohdev [at] gmail.com]
-- // License:   GNU GENERAL PUBLIC LICENSE
-- ///////////////////////////////////////////////////////////////////

local yaci_class = require 'lide.core.oop.yaci'

local function newclass ( sClassName )	
	if type(sClassName) == 'string'  then
		lide.classes [sClassName] = yaci_class (sClassName)
	else
		assert('error subclase no es string')
	end

	return lide.classes[sClassName]
end

lide.class = newclass

--backward compatibility:
class = lide.class

lide.classes.object = require 'lide.classes.object'

return class