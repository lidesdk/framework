-- ///////////////////////////////////////////////////////////////////
-- // Name:        lide.core.init.lua
-- // Purpose:     Define and initialize framework values
-- // Created:     2016/01/03
-- // Copyright:   (c) 2016 Dario Cano [dcanohdev@gmail.com]
-- // License:     lide license
-- ///////////////////////////////////////////////////////////////////

io.stdout:setvbuf 'no'
io.stderr:setvbuf 'no'

if (not os.getenv('LIDE_PATH')) then
    error 'LIDE_PATH is not defined now.'
end

lide = lide or {
	cons   = {}, 	--> This table saves all constants
	errorf = {}, 	--> This table stores all error functions
	
	core   = {
		error  = {},  --> stores all variables related to exceptions control
		base   = {},
		lua    = { type = type, error = error, require = require },
		file   = {},  --> stores all variables related to file handling
		folder = {},
	},

	base = {
		file = {},
	},

	classes = {
		widgets  = {},
		controls = {},
	}, 	--> stores all classes

	platform = {},
	app = {}
}

-- if interpreter
if arg and arg[0] then
	local sf = arg[0]:sub(1, #arg[0] , #arg[0])
	local n  = sf:reverse():find (package.config:sub(1,1), 1) or 0
		  sf = sf:reverse():sub (n+1, # sf:reverse()) : reverse()
	_sourcefolder = sf
end

require 'lide.core.thlua'

lide.core.error  = require 'lide.core.error' 	--> Exceptions control
lide.core.oop    = require 'lide.core.oop.init' --> OOP handling
lide.core.base   = require 'lide.core.base'		--> Base functions

-- load lide framework depends:
lide.core.lib = {
	lfs = require 'lfs', -- depends to lide filesystem:
}

-- load lide.platform:
lide.core.platform = require 'lide.core.platform'; 
lide.platform = lide.core.platform;

-- define base framework values:
lide.enum  = lide.core.base.enum;
lide.class = lide.core.oop.class;

-- Backward compatibility:
enum  = lide.enum    -- !Deprecated enum by lide.enum 
class = lide.class   -- !Deprecated class by lide.class
----------------------------------------------------------------------

-- Backward compatibility:
require 'lide.base.init' -- !Deprecated load modules by separate
----------------------------------------------------------------------

return lide, lide.app